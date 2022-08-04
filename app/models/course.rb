class Course < ApplicationRecord
  belongs_to :user
  has_many :enrollments
  has_many :users, through: :enrollments, source: :user
  has_many :quizzes
  has_many :questions
  has_many :teams
end
