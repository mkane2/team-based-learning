class Team < ApplicationRecord
  belongs_to :course
  has_many :users
  has_many :attempt_choices
  has_many :attempts

  validates :name, format: { with: /\A[a-zA-Z0-9\s]+\z/i, message: " %{value} can only contain letters and numbers." }
  validates_uniqueness_of :name, {message: "%{value} has already been taken."}

  def self.batch_import(file)
    require 'csv'
    teams = []
    errors = []
    CSV.foreach(file.path, headers: true) do |row|
      team = Team.new (row.to_h)
      if team.valid?
        team = Team.create! (row.to_h)
      else
        errors << team.errors.full_messages
      end
    end
    errors
  end
end
