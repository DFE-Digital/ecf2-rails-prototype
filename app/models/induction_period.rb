class InductionPeriod < ApplicationRecord
  include Period

  belongs_to :appropriate_body
  belongs_to :ect_at_school_period
  has_many :training_periods
end
