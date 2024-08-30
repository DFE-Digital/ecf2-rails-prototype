module Declarations
  class Find
    attr_reader :lead_provider

    def initialize(lead_provider:, academic_year:)
      @lead_provider = lead_provider
      @academic_year = academic_year
    end

    def all
      # FIXME should really union this
      [
        # declarations that were made by `lead provider`
        declarations_made_by_current_lead_provider,

        # declarations made by other lead providers that belong to
        # participants currently trained by `lead provider`
        declarations_made_by_previous_lead_providers
      ]
    end

    def declarations_made_by_current_lead_provider
      Declaration
        .joins(training_period: :provider_partnership)
        .merge(ProviderPartnership.where(lead_provider:))
    end

    def declarations_made_by_previous_lead_providers
      Declaration
        .joins(training_period: [:provider_partnership, :ect_at_school_period])
        .merge(ProviderPartnership.where.not(lead_provider:))
        .merge(ECTAtSchoolPeriod.where(teacher: teachers_currently_being_trained_by_lead_provider))
    end

    def teachers_currently_being_trained_by_lead_provider
      Teacher
        .joins(open_ect_at_school_periods: { open_training_periods: :provider_partnership })
        .merge(ProviderPartnership.where(lead_provider:, academic_year: @academic_year))
    end
  end
end