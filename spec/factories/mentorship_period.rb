FactoryBot.define do
  factory :mentorship_period do
    association :mentee, factory: :ect_at_school_period
    association :mentor, factory: :mentor_at_school_period
    started_on { 2.weeks.ago }
  end
end
