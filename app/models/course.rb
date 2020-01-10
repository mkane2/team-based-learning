class Course < ApplicationRecord
  belongs_to :user
  has_many :enrollments
  has_many :users, through: :enrollment
  has_many :quizzes
  has_many :questions
  has_many :teams
end
