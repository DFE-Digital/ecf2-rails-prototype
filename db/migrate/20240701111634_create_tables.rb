class CreateTables < ActiveRecord::Migration[7.1]
  def change
    create_table :academic_years do |t|
      t.integer :year, null: false
    end

    create_table :lead_providers do |t|
      t.string :name
    end

    create_table :delivery_partners do |t|
      t.string :name
    end

    create_table :teachers do |t|
      t.string :name
    end

    create_table :appropriate_bodies do |t|
      t.string :name
    end

    create_table :gias_schools, primary_key: :urn do |t|
      t.string :name, null: false
      t.integer :ukprn
      t.integer :school_phase_type
      t.string :school_phase_name
      t.integer :school_type_code
      t.string :school_type_name
      t.integer :school_status_code
      t.string :school_status_name
      t.string :administrative_district_code
      t.string :administrative_district_name
      t.string :address_line1, null: false
      t.string :address_line2
      t.string :address_line3
      t.string :postcode, null: false
      t.string :primary_contact_email
      t.string :secondary_contact_email
      t.string :school_website
      t.boolean :section_41_approved
      t.integer :la_code
      t.integer :establishment_number
      t.date :open_date
      t.date :close_date
      t.integer :easting
      t.integer :northing
    end

    create_table :schools do |t|
      t.references :gias_school
      t.string :name
    end

    create_table :ect_at_school_periods do |t|
      t.references :school
      t.references :teacher
      t.date :started_on, null: false
      t.date :finished_on
      t.index "school_id, teacher_id, ((finished_on IS NULL))", unique: true, where: "(finished_on IS NULL)"
    end

    create_table :mentor_at_school_periods do |t|
      t.references :school
      t.references :teacher
      t.date :started_on, null: false
      t.date :finished_on
      t.index "school_id, teacher_id, ((finished_on IS NULL))", unique: true, where: "(finished_on IS NULL)"
    end

    create_table :mentorship_periods do |t|
      t.references :ect_at_school_period
      t.references :mentor_at_school_period
      t.date :started_on, null: false
      t.date :finished_on
      t.index "ect_at_school_period_id, mentor_at_school_period_id, ((finished_on IS NULL))", unique: true, where: "(finished_on IS NULL)"
    end

    create_table :provider_partnerships do |t|
      t.references :academic_year
      t.references :lead_provider
      t.references :delivery_partner
    end

    create_table :training_periods do |t|
      t.references :provider_partnership
      t.references :ect_at_school_period
      t.references :mentor_at_school_period
      t.date :started_on, null: false
      t.date :finished_on
      t.index "ect_at_school_period_id, mentor_at_school_period_id, provider_partnership_id, ((finished_on IS NULL))", unique: true, where: "(finished_on IS NULL)"
    end

    create_table :declarations do |t|
      t.references :training_period
      t.string :declaration_type
    end

    create_table :induction_periods do |t|
      t.references :ect_at_school_period
      t.references :appropriate_body
      t.date :started_on, null: false
      t.date :finished_on
      t.index "ect_at_school_period_id, ((finished_on IS NULL))", unique: true, where: "(finished_on IS NULL)"
    end
  end
end
