class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices
  has_many :attempt_choices
  accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true

  def self.batch_import(file)
    require 'csv'
    questions = []
    errors = []
    CSV.foreach(file.path, headers: true) do |row|
      q = Question.new (row.to_h)
      if q.valid?
        q = Question.create! (row.to_h)
      else
        errors << q.errors.full_messages
      end
    end
    errors
  end
end
