# frozen_string_literal: true

require "gias/api_client"
require "csv"

module GIAS
  class SchoolImporter
    include Types

    def import_and_update_school_data_from_GIAS
      import_only = GIAS::School.count.zero?

      # import only doesn't try to work out what has changed and does not include "closed" schools
      if import_only
        # need to import schools first in an empty DB
        # import_and_update_schools_from_csv(school_data_file:, import_only:)
        import_school_links_from_csv(school_links_file:)
      else
        import_school_links_from_csv(school_links_file:)
        import_and_update_schools_from_csv(school_data_file:, import_only:)
      end
    end

    def import_and_update_schools_from_csv(school_data_file:, import_only: false)
      CSV.foreach(school_data_file, headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
        next unless eligible_row? row

        school_attrs = filtered_attributes(row)

        if import_only
          import_school(school_attrs)
        else
          update_school(school_attrs)
        end
      end
    end

    def import_school_links_from_csv(school_links_file:)
      CSV.foreach(school_links_file, headers: true, encoding: "ISO-8859-1:UTF-8") do |row|
        link_attrs = link_attributes(row)

        school = GIAS::School.find_by(urn: link_attrs[:urn])

        if school.present?
          link = school.school_links.find_by(link_urn: link_attrs[:link_urn])

          if link.present?
            if link.link_type != link_attrs[:link_type]
              link.update!(link_type: link_attrs[:link_type])
            end
          else
            school.school_links.create!(link_attrs.except(:urn))
          end
        end
      end
    end

  private

    def import_school(school_attrs)
      return if school_attrs.fetch(:school_status).in? %w[closed proposed_to_open]

      school = GIAS::School.find_by(urn: school_attrs.fetch(:urn))

      return if school.present?

      school = GIAS::School.create!(school_attrs)
      school.create_counterpart!
    end

    def update_school(school_attrs)
      school = GIAS::School.find_by(urn: school_attrs.fetch(:urn))

      if school.present?
        update_and_sync_changes!(school, school_attrs)
      else
        return if school_attrs.fetch(:school_status).in? %w[closed proposed_to_open]

        school = GIAS::School.create!(school_attrs)
        school.create_counterpart!
      end
    end

    def school_data_file
      gias_files["ecf_tech.csv"].path
    end

    def school_links_file
      gias_files["links.csv"].path
    end

    def gias_files
      @gias_files ||= gias_api_client.get_files
    end

    def gias_api_client
      @gias_api_client ||= GIAS::ApiClient.new
    end

    def update_and_sync_changes!(school, school_attributes)
      school.assign_attributes(school_attributes)
      return unless school.changed?

      changes = school.changes

      GIAS::School.transaction do
        school.save!

        # TODO: Handle changes such as closures and merges etc.
        #       Simple academisations type close/reopen will be just changing the :urn on the conterpart
        #       but links that are mergers and splits will need further thought
      end
    end

    def eligible_row?(row)
      establishment_type = row.fetch("TypeOfEstablishment (code)").to_i

      english_district_code?(row.fetch("DistrictAdministrative (code)")) &&
        (eligible_establishment_code?(establishment_type) ||
         cip_only_establishment_code?(establishment_type) ||
         row.fetch("Section41Approved (name)") == "Approved")
    end

    def extract_values_from(changes_hash)
      changes_hash.transform_values(&:last)
    end

    def filtered_attributes(data)
      {
        urn: data.fetch("URN").to_i,
        name: data.fetch("EstablishmentName"),
        ukprn: data.fetch("UKPRN").presence,
        school_phase_type: data.fetch("PhaseOfEducation (code)").to_i,
        school_phase_name: data.fetch("PhaseOfEducation (name)"),
        address_line1: data.fetch("Street"),
        address_line2: data.fetch("Locality").presence,
        address_line3: data.fetch("Town").presence,
        postcode: data.fetch("Postcode"),
        school_website: data.fetch("SchoolWebsite").presence,
        primary_contact_email: data.fetch("MainEmail").presence,
        secondary_contact_email: data.fetch("AlternativeEmail").presence,
        school_type_code: data.fetch("TypeOfEstablishment (code)").to_i,
        school_type_name: data.fetch("TypeOfEstablishment (name)"),
        school_status: make_status_value(data.fetch("EstablishmentStatus (name)")),
        administrative_district_code: data.fetch("DistrictAdministrative (code)"),
        administrative_district_name: data.fetch("DistrictAdministrative (name)"),
        section_41_approved: data.fetch("Section41Approved (name)") == "Approved",
        la_code: data.fetch("LA (code)").to_i,
        establishment_number: data.fetch("EstablishmentNumber").presence,
        open_date: data.fetch("OpenDate"),
        close_date: data.fetch("CloseDate"),
        easting: data.fetch("Easting").to_i,
        northing: data.fetch("Northing").to_i,
      }
    end

    def link_attributes(data)
      {
        urn: data.fetch("URN"),
        link_urn: data.fetch("LinkURN"),
        link_type: data.fetch("LinkType"),
      }
    end

    def make_status_value(status)
      status.underscore.parameterize(separator: "_").sub("open_but_", "")
    end
  end
end
