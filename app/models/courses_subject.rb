class CoursesSubject < ActiveRecord::Base
  STATUS = {
    new: 0,
    started: 1,
    finished: 2
  }

  belongs_to :course
  belongs_to :subject
end
