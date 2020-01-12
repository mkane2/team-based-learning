class Team < ApplicationRecord
  belongs_to :course
  has_many :users
  has_many :attempt_choices
  has_many :attempts

  validates :name, format: { with: /\A[a-zA-Z0-9\s]+\z/i, message: "can only contain letters and numbers." }, uniqueness: true

  def self.batch_import(file)
    require 'csv'
    users = []
    CSV.foreach(file.path, headers: true) do |row|
      Team.create!(row.to_h)
    end
  end
end
