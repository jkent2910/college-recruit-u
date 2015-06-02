Rails.application.routes.draw do
  resources :student_profiles
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks"}

  root 'welcome#index'

  get 'welcome/index'
end
