Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  root             "static_pages#home"
  get "home"    => "static_pages#home"
  get "about"   => "static_pages#about"
  get "contact" => "static_pages#contact"

  resources :subjects
  resources :courses_subjects
  resources :users, only: [:index, :show, :update]
  resources :courses, only: [:show]

  namespace :supervisor do
    root "courses#index"
    resources :users, only: [:index, :destroy]
    resources :subjects
    resources :courses do
      resources :courses_subjects, only: [:show, :edit, :update]
    end
  end
end
