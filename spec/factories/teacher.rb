FactoryBot.define do
  factory :teacher do
    transient do
      lead_provider { create(:lead_provider) }
      academic_year { create(:academic_year) }
    end

    # lets see how messy this gets
    trait :in_ect_training do
      after(:create) do |teacher, options|
        ect_at_school_period = create(:ect_at_school_period, teacher:)
        mentorship_period = create(:mentorship_period, mentee: ect_at_school_period)
        induction_period = create(:induction_period, ect_at_school_period:)
        provider_partnership = create(:provider_partnership, lead_provider: options.lead_provider, academic_year: options.academic_year)
        training_period = create(:training_period, induction_period:, provider_partnership:)
      end
    end

    trait :in_ect_training_with_declarations do
      after(:create) do |teacher, options|
        ect_at_school_period = create(:ect_at_school_period, teacher:)
        mentorship_period = create(:mentorship_period, mentee: ect_at_school_period)
        induction_period = create(:induction_period, ect_at_school_period:)
        provider_partnership = create(:provider_partnership, lead_provider: options.lead_provider, academic_year: options.academic_year)
        training_period = create(:training_period, induction_period:, provider_partnership:)
        create(:declaration, training_period:)
      end
    end
  end
end
