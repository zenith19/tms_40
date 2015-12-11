class CoursesSubject < ActiveRecord::Base
  STATUS = {
    new: 0,
    started: 1,
    finished: 2
  }

  attr_accessor :update_status

  belongs_to :course
  belongs_to :subject
  has_many :users_subjects, dependent: :destroy
  has_many :courses_subjects_tasks, dependent: :destroy
  has_many :tasks, through: :courses_subjects_tasks

  def new?
    status == STATUS[:new]
  end

  def started?
    status == STATUS[:started]
  end

  def finished?
    status == STATUS[:finished]
  end
end
