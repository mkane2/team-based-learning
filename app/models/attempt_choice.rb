class AttemptChoice < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
  belongs_to :choice
  belongs_to :user
  belongs_to :team, optional: true
  #validates_uniqueness_of :choice, scope: %i[user_id team_id]
  validates_uniqueness_of :choice, scope: %i[team_id attempt_id user_id]
  validates_uniqueness_of :question, scope: %i[attempt_id user_id], if: :individual_attempt?

  def individual_attempt?
    team_id == nil
  end
end
