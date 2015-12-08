class Course < ActiveRecord::Base
  has_many :users_course
  has_many :users, through: :users_course
end
