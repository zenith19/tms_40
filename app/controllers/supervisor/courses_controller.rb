class Supervisor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_course, except: :index

  def index
    @courses = current_user.courses.paginate page: params[:page],
      per_page: 10
  end

  def show
  end

  def edit    
    unless @course.new?
      @course = Course.find params[:id]
    else
      flash[:danger] = t '.danger'
      redirect_to supervisor_courses_path
    end    
  end

  def update
    @course.attributes = {'subject_ids' => []}.merge(params[:course] || {})
    if @course.update_attributes course_params
      redirect_to supervisor_course_path(@course)
    else
      render :edit
    end
  end

  private
  def load_course
    @course = Course.find params[:id]
  end

  def course_params
    params.require(:course).permit :name, :description, :start_date, :end_date, 
      'subject_ids' => []
  end
end