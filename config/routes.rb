Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root             "static_pages#home"
  get "home"    => "static_pages#home"
  get "about"   => "static_pages#about"
  get "contact" => "static_pages#contact"

  resources :subjects
end
