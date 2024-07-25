module GIAS
  class School < ApplicationRecord
    include GIAS::Helpers

    self.table_name = "gias_schools"

    has_many :schools
  end
end
