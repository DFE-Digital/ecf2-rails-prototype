class TrainingPeriod < ApplicationRecord
  include Period

  belongs_to :provider_partnership, optional: true
  belongs_to :induction_period, optional: true
  belongs_to :mentor_at_school, optional: true
  has_many :declarations
end
