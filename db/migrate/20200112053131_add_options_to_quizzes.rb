class AddOptionsToQuizzes < ActiveRecord::Migration[5.1]
  def change
    add_column :quizzes, :due_date, :datetime
    add_column :quizzes, :randomize_questions, :bool, default: false
    add_column :quizzes, :randomize_answers, :bool, default: false
    add_column :quizzes, :show_all_questions, :bool, default: true
    add_column :quizzes, :active, :bool, default: true
  end
end
