FactoryBot.define do
  factory :mentorship_period do
    association :mentee, factory: :teacher
    association :mentor, factory: :teacher
    started_on { 2.weeks.ago }
  end
end
