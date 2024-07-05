require "rails_helper"

RSpec.describe Declarations::Find do
  let(:lead_provider) { create(:lead_provider) }
  let(:academic_year) { create(:academic_year) }
  let(:edmund) { create(:teacher, :in_ect_training_with_declarations, name: "Edmund", lead_provider:, academic_year:) }
  let(:edmunds_declaration) { edmund.ect_at_school_periods.first.induction_periods.first.training_periods.first.declarations.first }

  subject(:service) { described_class.new(lead_provider:, academic_year:) }

  it "should include edmunds declaration" do
    expect(service.all.compact).to include [edmunds_declaration]
  end
end
