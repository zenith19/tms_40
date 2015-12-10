class Supervisor::CoursesSubjectsController < ApplicationController
  before_action :load_courses_subject
  before_action :check_courses_subject

  def show
    @course = @course_subject.course
    @subject = @course_subject.subject
    @tasks = @course_subject.tasks
  end

  def edit
  end

  def update
    if @courses_subject.update_attributes courses_subject_params
      redirect_to supervisor_course_courses_subject_path(
        id: @courses_subject.id, course_id: @courses_subject.course.id)
    else
      render :edit
    end
  end

  private
  def load_courses_subject
    @courses_subject = CoursesSubject.find params[:id]
  end

  def courses_subject_params
    params.require(:courses_subject).permit task_ids: []
  end

  def check_courses_subject
    if @courses_subject.started? || @courses_subject.finished?
      flash[:danger] = t '.danger'
      redirect_to supervisor_courses_path      
    end
  end
end