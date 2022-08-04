class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :courses
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :quizzes
  has_many :attempts, dependent: :destroy
  has_many :attempt_choices, dependent: :destroy
  belongs_to :team, optional: true
   validates_presence_of     :username, format: { with: /\A[a-zA-Z0-9\s]+\z/i, message: "can only contain letters and numbers." } # required
   validates_uniqueness_of   :username, message: "%{value} is already taken" # required
   validate :email_domain
   validates_uniqueness_of :email, message: "%{value} is already taken"
   accepts_nested_attributes_for :team, reject_if: :all_blank

   def email_domain
     domain = email.split("@").last
     if !email.blank?
       errors.add(:email, "Invalid email domain") if domain != Rails.configuration.school_email_domain
     end
   end

   def self.batch_import(file)
     require 'csv'
     users = []
     errors = []
     @course = Course.first
     CSV.foreach(file.path, headers: true) do |row|
       user = User.new email: row['email'], admin: row['admin'], username: row['username'], team_id: row['team_id'], studentid: row['studentid'], firstname: row['firstname'], lastname: row['lastname'], password: row['password']
       if user.valid?
         user = User.create! email: row['email'], admin: row['admin'], username: row['username'], team_id: row['team_id'], studentid: row['studentid'], firstname: row['firstname'], lastname: row['lastname'], password: row['password']
         enrollment = Enrollment.create! course_id: row['course_id'], user_id: user.id
       else
         errors << user.errors.full_messages
       end
     end
     errors
   end

end
