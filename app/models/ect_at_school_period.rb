class ECTAtSchoolPeriod < ApplicationRecord
  include Period

  has_many :mentorship_periods
  has_many :induction_periods
  has_many :training_periods
  has_many :open_induction_periods, -> { open }, class_name: "InductionPeriod"
  has_many :closed_induction_periods, -> { closed }, class_name: "InductionPeriod"
  has_many :open_training_periods, -> { open }, class_name: "TrainingPeriod"
  has_many :closed_training_periods, -> { closed }, class_name: "TrainingPeriod"

  belongs_to :school
  belongs_to :teacher
end
