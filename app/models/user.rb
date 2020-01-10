class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :courses
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :quizzes
  has_many :attempts
  has_many :attempt_choices
  belongs_to :team, optional: true
   validates_presence_of     :username # required
   validates_uniqueness_of   :username # required
   validate :email_domain

   acts_as_voter

   def email_domain
     domain = email.split("@").last
     if !email.blank?
       errors.add(:email, "Invalid Domain") if domain != "albany.edu"
     end
   end
end
