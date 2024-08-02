class InductionPeriod < ApplicationRecord
  include Period

  belongs_to :appropriate_body, optional: true
  belongs_to :ect_at_school_period
end
