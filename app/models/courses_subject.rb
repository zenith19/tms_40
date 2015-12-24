class CoursesSubject < ActiveRecord::Base
  acts_as_paranoid

  enum status: [:created, :started, :finished]

  attr_accessor :update_status

  belongs_to :course
  belongs_to :subject
  has_many :users_subjects, dependent: :destroy
  has_many :users, through: :users_subjects
  has_many :courses_subjects_tasks, dependent: :destroy
  has_many :tasks, through: :courses_subjects_tasks
end
