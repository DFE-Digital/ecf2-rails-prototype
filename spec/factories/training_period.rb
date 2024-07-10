FactoryBot.define do
  factory :training_period do
    transient do
      lead_provider { create(:lead_provider) }
      academic_year { create(:academic_year) }
      with_declarations { false }
    end

    started_on { 2.weeks.ago }

    trait :with_provider do
      after(:create) do |training_period, options|
        training_period.update!(provider_partnership: create(:provider_partnership, lead_provider: options.lead_provider, academic_year: options.academic_year))
        create(:declaration, training_period:) if options.with_declarations
      end
    end
  end
end
