class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices
  has_many :attempt_choices
  accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true

  def self.batch_import(file)
    require 'csv'
    questions = []
    errors = []
    get_headers = CSV.read(file.path, headers: true)
    headers = get_headers.headers
    choice_count = 0
    puts "headers #{headers}"
    headers.each do |header|
      puts "header #{header}"
      unless header.nil?
        if header.include? "choice_body"
          choice_count += 1
        end
      end
    end
    puts "this many choices #{choice_count}"
    CSV.foreach(file.path, headers: true) do |row|
      q = Question.new body: row['body'], quiz_id: row['quiz_id']
      if q.valid?
        q = Question.create! body: row['body'], quiz_id: row['quiz_id']
         choice_count.times do |choice|
           c = Choice.new quiz_id: row['quiz_id'], question_id: q.id, choice_body: row['choice_body_' + choice.to_s], correct: row['correct_' + choice.to_s]
           if c.valid?
             c = Choice.create! quiz_id: row['quiz_id'], question_id: q.id, choice_body: row['choice_body_' + choice.to_s], correct: row['correct_' + choice.to_s]
           else
             errors << c.errors.full_messages
           end
         end
      else
        errors << q.errors.full_messages
      end
    end
    errors
  end
end
