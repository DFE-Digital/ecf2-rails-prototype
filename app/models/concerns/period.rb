module Period
  extend ActiveSupport::Concern

  included do
    scope(:open, -> { where(finished_on: nil) })
    scope(:closed, -> { where.not(finished_on: nil) })
  end
end
