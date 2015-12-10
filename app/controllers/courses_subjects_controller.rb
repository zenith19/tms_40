class CoursesSubjectsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @courses_subject = CoursesSubject.find params[:id]
  end
end
