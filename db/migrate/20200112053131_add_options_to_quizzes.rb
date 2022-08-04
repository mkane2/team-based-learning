class AddOptionsToQuizzes < ActiveRecord::Migration[5.1]
  def change
    add_column :quizzes, :due_date, :datetime
    add_column :quizzes, :randomize_questions, :boolean, default: false
    add_column :quizzes, :randomize_answers, :boolean, default: false
    add_column :quizzes, :show_all_questions, :boolean, default: true
    add_column :quizzes, :active, :boolean, default: true
  end
end
