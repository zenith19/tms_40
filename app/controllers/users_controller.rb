class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: [:show, :update]

  def index
    @search = User.trainee.search params[:q]
    @users = @search.result.paginate page: params[:page], per_page: 15
  end
  def show
    @activities = @user.activities.paginate page: params[:page]
  end

  def update
    if @user.update_attributes user_params
      redirect_to edit_courses_subject_path
    else
      render "courses_subject/edit"
    end
  end

  private
  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit task_ids: []
  end
end
