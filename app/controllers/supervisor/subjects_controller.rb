class Supervisor::SubjectsController < ApplicationController
  before_action :load_subject, only: [:edit, :update, :destroy]
  load_and_authorize_resource :course

  def index
    @search = Subject.search params[:q]
    @subjects = @search.result.paginate page: params[:page], per_page: 15
  end

  def show
    @subject = Subject.find params[:id]
    @tasks = @subject.tasks
    @subject_activities = PublicActivity::Activity.order("created_at desc").
      where trackable_type: "Subject", trackable_id: @subject.id
  end

  def new
    @subject = Subject.new
    @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      redirect_to supervisor_subjects_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      redirect_to supervisor_subjects_path
    else
      render :edit
    end
  end

  def destroy
    @subject.destroy
    redirect_to supervisor_subjects_path
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
