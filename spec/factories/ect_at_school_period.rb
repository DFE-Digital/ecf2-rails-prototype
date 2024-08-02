FactoryBot.define do
  factory :ect_at_school_period do
    teacher
    school
    started_on { 2.weeks.ago }
  end
end
