class ECTAtSchoolPeriod < ApplicationRecord
  include Period

  has_many :mentorship_periods
  has_many :induction_periods
  has_many :open_induction_periods, -> { open }, class_name: "InductionPeriod"
  has_many :closed_induction_periods, -> { closed }, class_name: "InductionPeriod"

  belongs_to :school
  belongs_to :teacher
end
