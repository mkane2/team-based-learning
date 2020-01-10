class Quiz < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :questions
  has_many :attempts
  validates :name, format: { with: /\A[a-zA-Z0-9\s]+\z/i, message: "can only contain letters and numbers." }
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end
