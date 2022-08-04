class ChangeAttemptsChoicesColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :attempt_choices, :choices_id, :choice_id
    rename_column :attempt_choices, :questions_id, :question_id
  end
end
