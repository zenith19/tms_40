class Subject < ActiveRecord::Base

  include PublicActivity::Model
  tracked owner: ->(controller, model) {controller && controller.current_user}
  acts_as_paranoid

  has_many :tasks , dependent: :destroy
  has_many :users_subject
  has_many :users, through: :users_subject
  has_many :course_subjects, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true
end
