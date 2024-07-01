emily = Teacher.create(name: "Emily")
emilio = Teacher.create(name: "Emilio")

mary = Teacher.create(name: "Mary")
michael = Teacher.create(name: "Michael")

springfield = School.create(name: "Springfield Elementary")
grange_hill = School.create(name: "Grange Hill")

academic_year_2021 = AcademicYear.create(year: 2021)
academic_year_2022 = AcademicYear.create(year: 2022)

ambition = LeadProvider.create(name: "Ambition")
edt = LeadProvider.create(name: "EDT")
# _bpn = LeadProvider.create(name: "Best Practice Network")
# _teach_first = LeadProvider.create(name: "Teach First")
# _capita = LeadProvider.create(name: "Capita")
# _ucl = LeadProvider.create(name: "UCL")
# niot = LeadProvider.create(name: "NioT")

academies_enterprise_trust = DeliveryPartner.create(name: "Academies Enterprise Trust")
ark_tsh = DeliveryPartner.create(name: "Ark Teaching School Hub")
blue_kite = DeliveryPartner.create(name: "Blue Kite Trust")

ambition_with_academies_enterprise_trust = ProviderPartnership.create(
  lead_provider: ambition,
  delivery_partner: academies_enterprise_trust,
  academic_year: academic_year_2021
)

edt_with_ark_tsh = ProviderPartnership.create(
  lead_provider: edt,
  delivery_partner: ark_tsh,
  academic_year: academic_year_2021
)

edt_with_blue_kite = ProviderPartnership.create(
  lead_provider: edt,
  delivery_partner: blue_kite,
  academic_year: academic_year_2021
)

five_counties_tsh = AppropriateBody.create(name: "Five Counties Teaching School Hub")
astra_tsh = AppropriateBody.create(name: "Astra Teaching School Hub")
manor_tsh = AppropriateBody.create(name: "Manor Teaching School Hub")

emily_at_springfield = ECTAtSchoolPeriod.create(teacher: emily, school: springfield, started_on: 5.years.ago)
emilio_at_grange_hill = ECTAtSchoolPeriod.create(teacher: emilio, school: grange_hill, started_on: 4.years.ago)

mary_at_springfield = MentorAtSchoolPeriod.create(teacher: mary, school: springfield, started_on: 4.years.ago)
michael_at_grange_hill = MentorAtSchoolPeriod.create(teacher: michael, school: grange_hill, started_on: 3.years.ago)

mary_mentors_emily = MentorshipPeriod.create(
  mentor: mary_at_springfield,
  mentee: emily_at_springfield,
  started_on: 2.years.ago
)

michael_mentors_emilio = MentorshipPeriod.create(
  mentor: michael_at_grange_hill,
  mentee: emilio_at_grange_hill,
  started_on: 18.months.ago
)

emily_at_springfield_with_five_counties_tsh = InductionPeriod.create(
  appropriate_body: five_counties_tsh,
  ect_at_school_period: emily_at_springfield,
  started_on: 2.years.ago
)

emlilio_at_grange_hill_with_astra_tsh = InductionPeriod.create(
  appropriate_body: astra_tsh,
  ect_at_school_period: emilio_at_grange_hill,
  started_on: 18.months.ago
)

def create_declarations(training_period, number)
  declarations = %w(created retained_1 retained_2 retained_3 retained_4 completed)

  declarations.first(number).each do |declaration_type|
    Declaration.create(training_period:, declaration_type:)
  end
end

InductionPeriod.all.each do |induction_period|
  TrainingPeriod.create(
    induction_period:,
    provider_partnership: ProviderPartnership.all.sample,
    started_on: induction_period.started_on
  ).tap do |tp|
    create_declarations(tp, [1,2,3,4,5,6].sample)
  end
end
