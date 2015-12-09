class CoursesController < ApplicationController
  def show
    @course = current_user.courses
  end
end
