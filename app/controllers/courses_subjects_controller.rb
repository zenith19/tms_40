class CoursesSubjectsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @courses_subject = CoursesSubject.find params[:id]
    @user_subject = @courses_subject.users_subjects.find_by(user: current_user).
      first
  end
end
