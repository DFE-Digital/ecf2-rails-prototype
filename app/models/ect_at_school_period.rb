class ECTAtSchoolPeriod < ApplicationRecord
  include Period

  has_many :induction_periods
  has_many :mentorship_periods
  belongs_to :school
  belongs_to :teacher
end
