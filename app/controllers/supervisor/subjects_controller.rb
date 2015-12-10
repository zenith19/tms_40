class Supervisor::SubjectsController < ApplicationController
  before_action :load_subject, only: [:edit, :update, :destroy]
  load_and_authorize_resource :course

  def index
    @subjects = Subject.paginate page: params[:page], per_page: 15
  end

  def new
    @subject = Subject.new
    @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      redirect_to subjects_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      redirect_to subjects_path
    else
      render :edit
    end
  end

  def destroy
    @subject.destroy
    redirect_to subjects_url
  end

  private
  def subject_params
    params.require(:subject).permit :id, :name, :description,
      tasks_attributes: [ :id, :name, :subject_id, :_destroy]
  end

  def load_subject
    @subject = Subject.find params[:id]
  end
end
