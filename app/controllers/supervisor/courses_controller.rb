class Supervisor::CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = current_user.courses.paginate page: params[:page],
      per_page: 10
  end
end
