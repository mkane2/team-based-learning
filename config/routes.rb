Rails.application.routes.draw do

  get 'admin/csv_template'
  get 'admin/generate_csv'
  get 'admin/download_csv'

  resources :enrollments
  resources :attempt_choices
  resources :teams, param: :name

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, param: :name

  get 'users/index'
  root 'users#index'
  resources :quizzes do
    resources :questions
    resources :attempts
  end
  resources :questions do
    resources :choices
  end
  resources :courses
  resources :memberships

  get 'quiz/:id/leaderboard', to: 'quizzes#leaderboard', as: 'leaderboard'

  get 'add_member', to: 'memberships#add_member'
  get 'admin_dashboard', to: 'admin#dashboard'
  get 'dashboard', to: 'users#dashboard'
  # get 'download', to: 'admin#download'
  match '/download' => 'admin#index', via: :get, defaults: { format: :csv }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
