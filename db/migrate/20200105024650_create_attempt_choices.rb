class CreateAttemptChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :attempt_choices do |t|
      t.references :attempts, foreign_key: true
      t.references :questions, foreign_key: true
      t.references :choices, foreign_key: true
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
