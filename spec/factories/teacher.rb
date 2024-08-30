FactoryBot.define do
  factory :teacher do
    transient do
      lead_provider { create(:lead_provider) }
      academic_year { create(:academic_year) }
      with_declarations { false }
    end

    # lets see how messy this gets
    trait :in_ect_training do
      after(:create) do |teacher, options|
        ect_at_school_period = create(:ect_at_school_period, teacher:)
        mentorship_period = create(:mentorship_period, mentee: ect_at_school_period)
        induction_period = create(:induction_period, ect_at_school_period:)
        training_period = create(:training_period, :with_provider,
                                 ect_at_school_period:,
                                 lead_provider: options.lead_provider,
                                 academic_year: options.academic_year,
                                 with_declarations: options.with_declarations)
      end
    end
  end
end
