class Task < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  acts_as_paranoid

  has_many :courses_subjects_tasks
  has_many :courses_subjects, through: :courses_subjects_tasks
  has_many :users_tasks
  has_many :users, through: :users_tasks
  has_many :courses_subjects_tasks, dependent: :destroy
  has_many :courses_subjects, through: :courses_subjects_tasks
end
