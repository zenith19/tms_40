class CoursesController < ApplicationController

  def show
    courses = current_user.courses
    @course = courses.last
    @subjects = current_user.subjects
  end
end
