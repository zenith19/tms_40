Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  root             "static_pages#home"
  get "about"   => "static_pages#about"
  get "contact" => "static_pages#contact"

  resources :subjects
  resources :users, only: [:index, :show, :update]
  resources :courses, only: [:show]
  resources :courses_subjects

  namespace :supervisor do
    root "courses#index"
    resources :users, only: [:index, :destroy]
    resources :subjects
    resources :courses do
      resources :courses_subjects, only: [:show, :edit, :update]
      match "/users_courses/edit/:assign_type", to:  "users_courses#update", via: [:patch]
      match "/users_courses/edit/:assign_type", to:  "users_courses#update", via: [:put]
    end
  end
  match "/supervisor/courses/:course_id/users_courses/edit/:assign_type", 
    to:  "supervisor/users_courses#edit", as: "edit_supervisor_course_users_course", 
    via: [:get]
end
