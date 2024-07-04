class Teacher < ApplicationRecord
  has_many :mentor_at_school_periods
  has_many :ect_at_school_periods
  has_many :closed_ect_at_school_periods, -> { closed }, class_name: "ECTAtSchoolPeriod"
  has_many :open_ect_at_school_periods, -> { open }, class_name: "ECTAtSchoolPeriod"
end
