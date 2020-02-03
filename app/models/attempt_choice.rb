class AttemptChoice < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
  belongs_to :choice
  belongs_to :user
  belongs_to :team, optional: true
  validates_uniqueness_of :choice, scope: %i[user_id team_id]
end
