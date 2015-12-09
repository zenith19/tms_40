class Course < ActiveRecord::Base
  STATUS = {
    new: 0,
    started: 1,
    finished: 2
  }

  has_many :users_courses
  has_many :courses_subjects
  has_many :users, through: :users_courses
  has_many :subjects, through: :courses_subjects

  def trainees
    User.joins(:courses).
      where("users.supervisor = ? AND courses.id = ?", false, self.id)
  end
  
  def supervisors
    User.joins(:courses).
      where("users.supervisor = ? AND courses.id = ?", true, self.id)
  end

  def new?
    self.status == STATUS.key(0)
  end
end