class Quiz < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :questions
  has_many :choices, through: :questions
  has_many :attempts
  # validates :name, format: { with: /\A[a-zA-Z0-9\s]+\z/i, message: "can only contain letters and numbers." }
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

  def self.batch_import(file, user_id)
    require 'csv'
    quizzes = []
    errors = []
    CSV.foreach(file.path, headers: true) do |row|
      row[:user_id] = user_id
      q = Quiz.new (row.to_h)
      if q.valid?
        q = Quiz.create! (row.to_h)
      else
        errors << q.errors.full_messages
      end
    end
    errors
  end
end
