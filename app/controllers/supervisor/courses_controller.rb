class Supervisor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_course, except: [:index, :new, :create]
  before_action :check_course, only: [:edit, :update]

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
  end

  def update
    if params.has_key? :update_status
      update_status!
      update_course start_finish_params
    else
      update_course course_params
    end
  end

  private
  def load_course
    @course = Course.find params[:id]
  end

  def start_finish_params
    params.require(:course).permit :update_status
  end

  def course_params
    params.require(:course).permit :name, :description, :start_date, :end_date, 
      subject_ids: []
  end

  def update_status!
    if @course.new?
      @course.status = Course::STATUS[:started]
    elsif @course.started?
      @course.status = Course::STATUS[:finished]
    end
  end

  def check_course
    if (@course.started? && !params.has_key?(:update_status)) || @course.finished?
      flash[:danger] = t '.danger'
      redirect_to supervisor_courses_path
    end
  end

  def update_course custom_params
    if @course.update_attributes custom_params
      redirect_to supervisor_course_path(@course)
    else
      render :edit
    end
  end
end