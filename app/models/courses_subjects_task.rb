class CoursesSubjectsTask < ActiveRecord::Base
  belongs_to :courses_subject
  belongs_to :task
end
