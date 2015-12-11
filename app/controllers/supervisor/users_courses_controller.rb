class Supervisor::UsersCoursesController < ApplicationController
  before_action :load_course
  before_action :load_users

  def edit    
  end

  def update
    if @course.update_attributes course_params
      redirect_to supervisor_course_path(@course)
    else
      render :edit
    end
  end

  private
  def load_course
    @course = Course.find params[:course_id]
  end

  def load_users
    @assign_type = params[:assign_type]
    if @assign_type == UsersCourse::ASSIGN_TYPE[:supervisor]
      @users = User.supervisors
    elsif @assign_type == UsersCourse::ASSIGN_TYPE[:supervisor]
      @users = User.trainees
    end
  end

  def course_params
    params.require(:course).permit user_ids: []
  end
end