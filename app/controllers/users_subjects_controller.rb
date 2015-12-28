class UsersSubjectsController < ApplicationController
  before_action :authenticate_user!

  def create
    @users_subject = UsersSubject.new user_subject_params
    if @users_subject.save
      redirect_to edit_courses_subject_path @users_subject.courses_subject_id
    else
      render "courses_subjects/edit"
    end
  end

  private
  def user_subject_params
    params.require(:users_subject).permit :user_id, :courses_subject_id
  end
end
