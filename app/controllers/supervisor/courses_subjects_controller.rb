class Supervisor::CoursesSubjectsController < ApplicationController

  def show
    @course_subject = CoursesSubject.find_by_course_id_and_subject_id params[:course_id], params[:subject_id]
    @course = @course_subject.course
    @subject = @course_subject.subject
    @tasks = @course_subject.tasks
  end

  def edit
  end

  def update
  end
end
