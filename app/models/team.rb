class Team < ApplicationRecord
  belongs_to :course
  has_many :users
  has_many :attempt_choices
  has_many :attempts

  validates :name, uniqueness: true
end
