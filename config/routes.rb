Rails.application.routes.draw do

  resources :course_options
  #get 'admin/csv_template'
  #get 'admin/generate_csv'
  #get 'admin/download_csv'

  resources :enrollments
  resources :attempt_choices
  resources :teams, param: :name do
    collection {post :import}
  end

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, param: :name do
    collection {post :import}
  end

  get '/import/:model' => 'admin#upload_create'
  get 'users/index'
  root 'users#index'
  resources :quizzes do
    resources :questions
    resources :attempts
    collection {post :import}
  end
  resources :questions do
    resources :choices
    collection {post :import}
  end
  resources :courses
  resources :memberships

  get 'quizzes/:id/leaderboard', to: 'quizzes#leaderboard', as: 'leaderboard'
  get 'quizzes/:id/scores', to: 'quizzes#scores', as: 'scores'
  get 'quizzes/:id/results', to: 'quizzes#results', as: 'results'
  get 'quizzes/:quiz_id/attempts/:attempt_id/students/:user_id', to: 'attempts#show_student', as: 'show_student'
  get 'quizzes/:quiz_id/attempts/:attempt_id/teams/:team_id', to: 'attempts#show_team', as: 'show_team'
  get 'questions/:question_id/students/:student_id', to: 'attempt_choices#show_attempts', as: 'view_attempt_choices'
  get 'questions/:question_id/teams/:team_id', to: 'attempt_choices#show_team_attempts', as: 'view_team_attempt_choices'
  get 'attempts/:id/rescore', to: 'attempts#rescore', as: 'rescore'

  get 'add_member', to: 'memberships#add_member'
  get 'admin_dashboard', to: 'admin#dashboard'
  get 'dashboard', to: 'users#dashboard'
  # get 'download', to: 'admin#download'
  match '/download' => 'admin#index', via: :get, defaults: { format: :csv }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
