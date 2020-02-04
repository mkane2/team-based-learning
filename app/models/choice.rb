class Choice < ApplicationRecord
  belongs_to :question
  belongs_to :quiz
  #  acts_as_votable
  has_many :attempt_choices
  validates_presence_of :choice_body
end
