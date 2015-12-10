class CoursesController < ApplicationController
  load_and_authorize_resource :course

  def show
    @course = current_user.courses
  end
end
