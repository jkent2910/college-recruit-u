Rails.application.routes.draw do
  resources :student_profiles do
    member do
      post :become_a_fan
      post :stop_being_a_fan
    end
  end

  resources :colleges do
    member do
      post :student_status
    end
  end

  get "search" => "search#index"
  post "search" => "search#search"

  devise_for :users

  root 'welcome#index'

  get 'welcome/index'
end
