class AddDefaultToAttempts < ActiveRecord::Migration[5.1]
  def change
    change_column :attempts, :points, :integer, default: 0
  end
end
