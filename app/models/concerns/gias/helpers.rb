# frozen_string_literal: true

module GIAS
  module Helpers
    extend ActiveSupport::Concern
    include GIAS::Types

    included do
      scope :currently_open, -> { where(school_status: %w[open proposed_to_close]) }
      scope :eligible_establishment_type, -> { where(school_type_code: GIAS::Types::ELIGIBLE_TYPE_CODES) }
      scope :in_england, -> { where("administrative_district_code ILIKE 'E%' OR administrative_district_code = '9999'") }
      scope :section_41, -> { where(section_41_approved: true) }
      scope :eligible, -> { currently_open.eligible_establishment_type.in_england.or(currently_open.in_england.section_41) }
      scope :cip_only, -> { currently_open.where(school_type_code: GIAS::Types::CIP_ONLY_TYPE_CODES) }
      scope :eligible_or_cip_only, -> { eligible.or(cip_only) }
      scope :not_cip_only, -> { where.not(id: cip_only) }
    end

    def name_and_urn
      "#{name} (#{urn})"
    end

    def full_address
      [address_line1, address_line2, address_line3, postcode].compact_blank.join("\n")
    end

    def open?
      open_status_code?(school_status_code)
    end

    def closed?
      !open_status_code?(school_status_code)
    end

    def eligible_establishment_type?
      eligible_establishment_code?(school_type_code)
    end

    def in_england?
      english_district_code?(administrative_district_code)
    end

    def british_school_overseas?
      school_type_code == 37
    end

    def independent_school?
      school_type_code == 10 || school_type_code == 11
    end
  end
end
