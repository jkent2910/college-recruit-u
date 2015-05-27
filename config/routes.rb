Rails.application.routes.draw do
  resources :student_profiles
  devise_for :users

  root 'welcome#index'

  get 'welcome/index'
end
