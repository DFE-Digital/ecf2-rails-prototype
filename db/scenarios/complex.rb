# academic year 2024 begins
academic_year_2024 = AcademicYear.find_by!(year: 2024)

# lead provider a reports provider partnership a with delivery partner a for 2024
ambition = LeadProvider.find_by!(name: "Ambition")
ark_tsh = DeliveryPartner.find_by!(name: "Ark Teaching School Hub")
ambition_with_ark_tsh_2024 = ProviderPartnership.create(
  lead_provider: ambition,
  delivery_partner: ark_tsh,
  academic_year: academic_year_2024
)

# lead provider b reports provider partnership b with delivery partner b for 2024
bpn = LeadProvider.find_by!(name: "Best Practice Network")
blue_kite = DeliveryPartner.find_by!(name: "Blue Kite Trust")
bpn_with_blue_kite_2024 = ProviderPartnership.create(
  lead_provider: bpn,
  delivery_partner: blue_kite,
  academic_year: academic_year_2024
)

# at school a
school_a = School.create(name: "A primary school")

# - participant a is registered at school a
emma = Teacher.create(name: "Emma")
emma_at_school_a = ECTAtSchoolPeriod.create(teacher: emma, school: school_a, started_on: 3.months.ago)
# - participant a is paired with mentor a at school a
mark = Teacher.create(name: "Mark")
mark_at_school_a = MentorAtSchoolPeriod.create(teacher: mark, school: school_a, started_on: 3.months.ago)
mark_mentors_emma_at_school_a = MentorshipPeriod.create(mentee: emma_at_school_a, mentor: mark_at_school_a, started_on: 2.months.ago)
# - induction period is registered by appropriate body a against participant a in 2024
appropriate_body_a = AppropriateBody.create(name: "Appropriate Body A")
appropriate_body_a_inducts_emma_at_school_a = InductionPeriod.new(ect_at_school_period: emma_at_school_a, appropriate_body: appropriate_body_a, started_on: 2.months.ago)
# - fip training period a is registered with lead provider a via provider partnership a
emma_trains_with_ambition_and_ark_2024_at_school_a = TrainingPeriod.create(
  induction_period: appropriate_body_a_inducts_emma_at_school_a,
  provider_partnership: ambition_with_ark_tsh_2024,
  started_on: 2.months.ago
)
# - provider a reports a started declaration against training period a
Declaration.create(training_period: emma_trains_with_ambition_and_ark_2024_at_school_a, declaration_type: "started")

# - participant a leaves school a
emma_at_school_a.update(finished_on: 1.month.ago)
appropriate_body_a_inducts_emma_at_school_a.update(finished_on: 1.month.ago)
emma_trains_with_ambition_and_ark_2024_at_school_a.update(finished_on: 1.month.ago)
mark_mentors_emma_at_school_a.update(finished_on: 1.month.ago)

# at school b
school_b = School.create(name: "B primary school")
# - participant a joins school b
emma_at_school_b = ECTAtSchoolPeriod.create(teacher: emma, school: school_b, started_on: 3.weeks.ago)
# - participant a is paired with mentor b at school b
maria = Teacher.create(name: "Maria")
maria_at_school_b = MentorAtSchoolPeriod.create(teacher: maria, school: school_b, started_on: 3.weeks.ago)
maria_mentors_emma_at_school_b = MentorshipPeriod.create(mentee: emma_at_school_a, mentor: maria_at_school_b, started_on: 3.weeks.ago)
# - induction period is registered by appropriate body b against participant a in 2024
appropriate_body_b = AppropriateBody.create(name: "Appropriate Body B")
appropriate_body_b_inducts_emma_at_school_b = InductionPeriod.new(ect_at_school_period: emma_at_school_b, appropriate_body: appropriate_body_b, started_on: 2.weeks.ago)
# - fip training period b is registered with lead provider b via provider partnership b
emma_trains_with_bpn_and_blue_kite_2024_at_school_b = TrainingPeriod.create(
  induction_period: appropriate_body_b_inducts_emma_at_school_b,
  provider_partnership: bpn_with_blue_kite_2024,
  started_on: 2.weeks.ago
)
# - provider b reports a retained-1 declaration against training period b
Declaration.create(training_period: emma_trains_with_bpn_and_blue_kite_2024_at_school_b, declaration_type: "retained-1")
