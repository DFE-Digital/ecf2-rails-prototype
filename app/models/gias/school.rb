module GIAS
  class School < ApplicationRecord
    include GIAS::Helpers

    self.table_name = "gias_schools"

    has_many :schools, class_name: "::School", foreign_key: :gias_school_id
  end
end
