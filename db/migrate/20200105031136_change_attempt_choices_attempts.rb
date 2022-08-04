class ChangeAttemptChoicesAttempts < ActiveRecord::Migration[5.1]
  def change
    rename_column :attempt_choices, :attempts_id, :attempt_id
  end
end
