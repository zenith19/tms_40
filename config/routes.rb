Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  root             "static_pages#home"
  get "about"   => "static_pages#about"
  get "contact" => "static_pages#contact"

  resources :activities
  resources :subjects
  resources :users, only: [:index, :show, :update]
  resources :courses, only: [:show]
  resources :courses_subjects
  resources :users_subjects

  namespace :supervisor do
    root "courses#index"
    resources :users, only: [:index, :destroy]
    resources :subjects
    resources :courses do
      resources :courses_subjects, only: [:show, :edit, :update]
      resource :assign_supervisors, only: [:show, :update]
      resource :assign_trainees, only: [:show, :update]
    end
  end
end
