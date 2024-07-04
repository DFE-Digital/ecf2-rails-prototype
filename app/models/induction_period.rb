class InductionPeriod < ApplicationRecord
  include Period

  belongs_to :appropriate_body, optional: true
  belongs_to :ect_at_school_period
  has_many :training_periods
  has_many :open_training_periods, -> { open }, class_name: "TrainingPeriod"
  has_many :closed_training_periods, -> { closed }, class_name: "TrainingPeriod"
end
