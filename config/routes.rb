Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  root             "static_pages#home"
  get "home"    => "static_pages#home"
  get "about"   => "static_pages#about"
  get "contact" => "static_pages#contact"

  resources :subjects
  resources :users, only: [:index, :show]
  namespace :supervisor do
    root 'courses#index'
    resources :users, only: :index
    resources :courses, except: [:new, :create, :destroy] do
      resources :courses_subjects, only: [:edit, :update]
    end
  end
end