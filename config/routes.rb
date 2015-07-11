Rails.application.routes.draw do
  resources :student_profiles do
    member do
      post :become_a_fan
      post :stop_being_a_fan
    end
  end

  resources :colleges

  devise_for :users

  root 'welcome#index'

  get 'welcome/index'
end
