class AttemptChoice < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
  belongs_to :choice
  belongs_to :user
  belongs_to :team, optional: true
end
