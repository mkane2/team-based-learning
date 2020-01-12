class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices
  has_many :attempt_choices
  accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true

  def self.batch_import(file)
    require 'csv'
    users = []
    CSV.foreach(file.path, headers: true) do |row|
      Question.create!(row.to_h)
    end
  end
end
