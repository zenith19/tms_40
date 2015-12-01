class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      redirect_to @course
    else
      redirect_to root_path
    end
  end

  def show
    @course = Course.find params[:id]
  end

  def edit
    @course = Course.find params[:id]
  end

  def update
    @course = Course.find params[:id]
    if @course.update_attributes course_params
      redirect_to @course
    else
      redirect_to root_path
    end
  end

  def destroy
    Course.find(params[:id]).destroy
    redirect_to root_path
  end

  private
  def course_params
    params.require(:course).permit :name, :description, :start_date, :end_date
  end
end
