class ProviderPartnership < ApplicationRecord
  belongs_to :academic_year
  belongs_to :lead_provider
  belongs_to :delivery_partner

  has_many :training_periods
  has_many :open_training_periods, -> { open }, class_name: "TrainingPeriod"
  has_many :closed_training_periods, -> { closed }, class_name: "TrainingPeriod"
end
