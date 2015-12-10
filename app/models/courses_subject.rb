class CoursesSubject < ActiveRecord::Base
  STATUS = {
    new: 0,
    started: 1,
    finished: 2
  }

  belongs_to :course
  belongs_to :subject
  has_many :courses_subjects_tasks
  has_many :tasks, through: :courses_subjects_tasks

  def finished?
    self.status == STATUS[:finished]
  end
end
