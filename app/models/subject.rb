class Subject < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  acts_as_paranoid

  validates :name, presence: true
  validates :description, presence: true
  has_many :tasks , dependent: :destroy
  has_many :users_subject
  has_many :users, through: :users_subject
  has_many :courses_subjects, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true
end
