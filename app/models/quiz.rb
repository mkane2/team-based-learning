class Quiz < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :questions
  has_many :attempts
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end
