class Supervisor::AssignTraineesController < ApplicationController
  before_action :load_course
  before_action :check_course
  before_action :load_users

  def show
  end

  def update
    if @course.update_attributes course_params
      @course.assigned_users.each do |user|
        UserMailer.delay.assigned_trainees user.full_name, user.email, @course.id
      end
      @course.removed_users.each do |user|
        UserMailer.delay.removed_trainees user.full_name, user.email, @course.id
      end
      redirect_to supervisor_course_path @course
    else
      render :show
    end
  end

  private
  def load_course
    @course = Course.find params[:course_id]
  end

  def load_users
    @users = User.assignable_trainees @course
  end

  def course_params
    params.require(:course).permit user_ids: []
  end

  def check_course
    if @course.started?
      flash[:danger] = t "flash_assign_trainees"
      redirect_to supervisor_course_path @course
    end
  end
end