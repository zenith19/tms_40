class Course < ActiveRecord::Base
  STATUS = {
    new: 0,
    started: 1,
    finished: 2
  }

  has_many :users_course
  has_many :users, through: :users_course
end
