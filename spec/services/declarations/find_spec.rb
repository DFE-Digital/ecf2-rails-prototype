require "rails_helper"

RSpec.describe Declarations::Find do
  let(:provider_a) { create(:lead_provider, name: "Provider A") }
  let(:provider_b) { create(:lead_provider, name: "Provider B") }
  let(:academic_year) { create(:academic_year) }
  let(:edmund) { create(:teacher, :in_ect_training, with_declarations: true, name: "Edmund", lead_provider: provider_a, academic_year:) }
  let!(:edmunds_declaration) { edmund.ect_at_school_periods.first.training_periods.first.declarations.first }

  let(:ethel) { create(:teacher, :in_ect_training, with_declarations: true, name: "Ethel", lead_provider: provider_b, academic_year:) }
  let!(:ethels_declaration) { ethel.ect_at_school_periods.first.training_periods.first.declarations.first }

  subject(:service) { described_class.new(lead_provider: provider_a, academic_year:) }

  describe "#all" do
    it "should include Edmund's declaration" do
      expect(service.all.compact).to include [edmunds_declaration]
    end

    it "should not include Ethel's declaration" do
      expect(service.all.compact).not_to include [ethels_declaration]
    end

    context "when Ethel changes to Provider A" do
      let(:ethels_ect_period) { ethel.ect_at_school_periods.first }
      let(:ethels_original_training_period) { ethels_ect_period.training_periods.first }
      let!(:ethels_new_training) do
        create(:training_period, :with_provider,
               ect_at_school_period: ethels_ect_period,
               lead_provider: provider_a,
               academic_year:,
               started_on: 14.hours.ago)
      end

      before do
        ethels_original_training_period.update!(finished_on: 1.day.ago)
      end

      it "should include Ethel's declaration" do
        expect(service.all.compact).to include [ethels_declaration]
      end
    end
  end
end
