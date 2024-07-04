class Declaration < ApplicationRecord
  belongs_to :training_period

  # In ECF1 there's a limit to 1 declaration of each type per participant
  #
  # However, it should be possible for multiuple providers to train the same
  # participant (ECT or Mentor) in the same milestone period (term), if:
  # - a participant transfers between schools during a term
  # - the school changes the provider partnership associated with the induction
  #   period
end
