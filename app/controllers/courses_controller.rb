class CoursesController < ApplicationController
  load_and_authorize_resource :course
  
  def show
    courses = current_user.courses
    @course = courses.last
    @subjects = @course.subjects
  end
end
