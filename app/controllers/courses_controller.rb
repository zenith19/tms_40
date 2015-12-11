class CoursesController < ApplicationController

  def show
    courses = current_user.courses
    @course = courses.last
    @subjects = @course.subjects
  end
end
