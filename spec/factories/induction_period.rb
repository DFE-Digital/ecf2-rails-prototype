FactoryBot.define do
  factory :induction_period do
    ect_at_school_period
    started_on { 2.weeks.ago }
  end
end
