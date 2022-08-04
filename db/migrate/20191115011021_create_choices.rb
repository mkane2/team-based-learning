class CreateChoices < ActiveRecord::Migration[5.1]
  def change
    create_table :choices do |t|
      t.text :body
      t.boolean :correct
      t.references :quiz, foreign_key: true

      t.timestamps
    end
  end
end
