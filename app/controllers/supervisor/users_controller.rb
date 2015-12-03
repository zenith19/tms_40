class Supervisor::UsersController < ApplicationController
  def index
    @users = User.all.paginate page: params[:page], per_page: 15
    if params[:supervisor] == User::TYPES[:supervisor]
      @users = User.supervisors.paginate page: params[:page], per_page: 15
    elsif params[:supervisor] == User::TYPES[:trainee]
      @users = User.trainees.paginate page: params[:page], per_page: 15
    end
  end
end
