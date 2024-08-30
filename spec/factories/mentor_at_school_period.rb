FactoryBot.define do
  factory :mentor_at_school_period do
    teacher
    school
    started_on { 2.weeks.ago }
  end
end
