class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  belongs_to :team, optional: true
  has_many :attempt_choices
end
