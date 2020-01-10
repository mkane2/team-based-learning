class AddPointsToAttempts < ActiveRecord::Migration[5.1]
  def change
    add_column :attempts, :points, :integer
  end
end
