class Supervisor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_course, except: [:index, :new, :create]

  def index
    @courses = current_user.courses.paginate page: params[:page], per_page: 10
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save!
      flash[:notice] = t 'flash_course_created'
      redirect_to [:supervisor, @course]
    else
      render :new
    end
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
    update_status! if params.has_key? :update_status
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
      :update_status, 'subject_ids' => []
  end

  def update_status!
    if @course.new?
      @course.status = Course::STATUS[:started]
    elsif @course.started?
      @course.status = Course::STATUS[:finished]
    end
  end
end