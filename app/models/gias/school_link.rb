module GIAS
  class SchoolLink < ApplicationRecord
    self.table_name = "gias_school_links"

    validates :link_urn, presence: true, uniqueness: { scope: :urn }
    validates :link_type, presence: true

    belongs_to :gias_school, class_name: "GIAS::School", foreign_key: :urn
  end
end
