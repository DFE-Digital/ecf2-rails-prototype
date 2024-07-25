class School < ApplicationRecord
  has_many :ect_at_school_periods
  has_many :open_ect_at_school_periods, -> { open }, class_name: "ECTAtSchoolPeriod"
  has_many :closed_ect_at_school_periods, -> { closed }, class_name: "ECTAtSchoolPeriod"

  has_many :mentor_at_schools
  has_many :open_mentor_at_school_periods, -> { open }, class_name: "MentorAtSchoolPeriod"
  has_many :closed_mentor_at_school_periods, -> { closed }, class_name: "MentorAtSchoolPeriod"

  belongs_to :gias_school, class_name: "GIAS::School"
end
