class CreateAttemtps < ActiveRecord::Migration[5.1]
  def change
    create_table :attemtps do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.references :quiz, foreign_key: true

      t.timestamps
    end
  end
end
