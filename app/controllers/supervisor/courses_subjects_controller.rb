class Supervisor::CoursesSubjectsController < ApplicationController
  before_action :load_courses_subject
  before_action :check_courses_subject, only: [:edit, :update]
  load_and_authorize_resource :course

  def show
    @course = @courses_subject.course
    @subject = @courses_subject.subject
    @tasks = @courses_subject.tasks
  end

  def edit
  end

  def update
    if courses_subject_params.has_key? :update_status
      update_status!
      redirect_to supervisor_course_courses_subject_path(
        id: @courses_subject.id, course_id: @courses_subject.course.id)
    else
      if @courses_subject.update_attributes courses_subject_params
        redirect_to supervisor_course_courses_subject_path(
          id: @courses_subject.id, course_id: @courses_subject.course.id)
      else
        render :edit
      end  
    end    
  end

  private
  def load_courses_subject
    @courses_subject = CoursesSubject.find params[:id]
  end

  def courses_subject_params
    params.require(:courses_subject).permit :update_status, task_ids: []
  end

  def update_status!
    if @courses_subject.new?
      @courses_subject.status = CoursesSubject::STATUS[:started]
      @courses_subject.users = @courses_subject.course.trainees      
    elsif @courses_subject.started?
      @courses_subject.status = CoursesSubject::STATUS[:finished]
    end
    @courses_subject.save!
  end

  def check_courses_subject
    course = @courses_subject.course
    if course.finished? || ((course.started? || @courses_subject.started?) && 
      !courses_subject_params.has_key?(:update_status)) ||
      @courses_subject.finished?

      flash[:danger] = t ".danger"
      redirect_to supervisor_courses_path
    end
  end
end
