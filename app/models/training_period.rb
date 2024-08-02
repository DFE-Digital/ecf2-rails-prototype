class TrainingPeriod < ApplicationRecord
  include Period

  belongs_to :ect_at_school_period
  belongs_to :provider_partnership, optional: true
  belongs_to :mentor_at_school, optional: true
  has_many :declarations
end
