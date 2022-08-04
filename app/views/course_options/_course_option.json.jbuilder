json.extract! course_option, :id, :randomize_questions, :randomize_answers, :show_all_questions, :active, :duration, :course_id, :user_id, :created_at, :updated_at
json.url course_option_url(course_option, format: :json)
