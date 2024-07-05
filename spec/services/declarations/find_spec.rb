require "rails_helper"

RSpec.describe Declarations::Find do
  let(:lead_provider) { create(:lead_provider) }
  let(:academic_year) { create(:academic_year) }
  let(:edmund) { create(:teacher, :in_ect_training, with_declarations: true, name: "Edmund", lead_provider:, academic_year:) }
  let!(:edmunds_declaration) { edmund.ect_at_school_periods.first.induction_periods.first.training_periods.first.declarations.first }
  let(:ethel) { create(:teacher, :in_ect_training, with_declarations: true, name: "Ethel", academic_year:) }
  let!(:ethels_declaration) { ethel.ect_at_school_periods.first.induction_periods.first.training_periods.first.declarations.first }

  subject(:service) { described_class.new(lead_provider:, academic_year:) }

  describe "#all" do
    it "should include Edmund's declaration" do
      expect(service.all.compact).to include [edmunds_declaration]
    end

    it "should not include Ethel's declaration" do
      expect(service.all.compact).not_to include [ethels_declaration]
    end
  end
end
