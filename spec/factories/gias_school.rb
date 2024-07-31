FactoryBot.define do
  factory :gias_school, class: "GIAS::School" do
    sequence :urn
    name { "Big School" }
    address_line1 { "High St" }
    postcode { "QQ11 2QQ" }
  end
end
