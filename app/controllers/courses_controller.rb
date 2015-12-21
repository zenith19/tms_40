class CoursesController < ApplicationController
  load_and_authorize_resource except: [:show]

  def show
    @course = current_user.courses.last
    @activities = @course.load_acitvities current_user
  end
end
