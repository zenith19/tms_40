class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: [:show]

  def index
    @users = User.trainees.paginate page: params[:page], per_page: 15
  end
  def show
    @activities = @user.activities.paginate page: params[:page]
  end

  private
  def load_user
    @user = User.find params[:id]
  end
end
