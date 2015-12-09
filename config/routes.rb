Rails.application.routes.draw do

  namespace :supervisor do
    root 'courses#index'
    resources :courses
    resources :users, only: [:index]
  end

  devise_for :users, controllers: { registrations: "registrations" }

  root             "static_pages#home"
  get "home"    => "static_pages#home"
  get "about"   => "static_pages#about"
  get "contact" => "static_pages#contact"

  resources :subjects
  resources :users, only: [:index, :show]

end
