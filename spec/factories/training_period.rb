FactoryBot.define do
  factory :training_period do
    induction_period
    started_on { 2.weeks.ago }
  end
end
