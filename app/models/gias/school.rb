module GIAS
  class School < ApplicationRecord
    include GIAS::Types

    validates :name, presence: true

    enum school_status: {
      open: "open",
      closed: "closed",
      proposed_to_close: "proposed_to_close",
      proposed_to_open: "proposed_to_open",
    }, _suffix: "status"

    self.table_name = "gias_schools"

    has_one :counterpart, class_name: "::School", foreign_key: :urn
    has_many :school_links, class_name: "GIAS::SchoolLink", foreign_key: :urn, dependent: :destroy

    scope :currently_open, -> { where(school_status: %w[open proposed_to_close]) }
    scope :eligible_establishment_type, -> { where(school_type_code: ELIGIBLE_TYPE_CODES) }
    scope :in_england, -> { where("administrative_district_code ILIKE 'E%' OR administrative_district_code = '9999'") }
    scope :section_41, -> { where(section_41_approved: true) }
    scope :eligible_for_funding, -> { currently_open.eligible_establishment_type.in_england.or(currently_open.in_england.section_41) }
    scope :cip_only, -> { currently_open.where(school_type_code: CIP_ONLY_TYPE_CODES) }
    scope :eligible_or_cip_only, -> { eligible.or(cip_only) }
    scope :not_cip_only, -> { where.not(id: cip_only) }
  end
end
