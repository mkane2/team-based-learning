class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices
  has_many :attempt_choices
  accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true
end
