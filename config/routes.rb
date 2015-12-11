Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  root             "static_pages#home"
  get "home"    => "static_pages#home"
  get "about"   => "static_pages#about"
  get "contact" => "static_pages#contact"

  resources :subjects
  resources :users, only: [:index, :show]
  resources :courses, only: [:show]

  namespace :supervisor do
    root "courses#index"
    resources :users, only: :index
    resources :courses, only: [:new, :create, :edit, :destroy, :show] do
      resources :courses_subjects, only: [:edit, :update, :show]
    end
  end
end
