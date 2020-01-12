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
   validates_presence_of     :username, format: { with: /\A[a-zA-Z0-9\s]+\z/i, message: "can only contain letters and numbers." } # required
   validates_uniqueness_of   :username, message: "%{value} is already taken" # required
   validate :email_domain
   validates_uniqueness_of :email, message: "%{value} is already taken"

   def email_domain
     domain = email.split("@").last
     if !email.blank?
       errors.add(:email, "Invalid email domain") if domain != "albany.edu"
     end
   end

   def self.batch_import(file)
     require 'csv'
     users = []
     errors = []
     CSV.foreach(file.path, headers: true) do |row|
       user = User.new (row.to_h)
       if user.valid?
         user = User.create! (row.to_h)
       else
         errors << user.errors.full_messages
       end
     end
     errors
   end

end
