class CreateCourseOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :course_options do |t|
      t.boolean :randomize_questions, default: false
      t.boolean :randomize_answers, default: false
      t.boolean :show_all_questions, default: true
      t.boolean :active, default: true
      t.integer :duration, default: nil
      t.references :course, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
