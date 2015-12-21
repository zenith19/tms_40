class Supervisor::UsersController < ApplicationController
  def index
    @users = User.all.paginate page: params[:page], per_page: 15
    if params[:supervisor] == User::TYPES[:supervisor]
      @search = User.supervisor.search params[:q]
      @users = @search.result.paginate page: params[:page], per_page: 15
    elsif params[:supervisor] == User::TYPES[:trainee]
      @search = User.trainee.search params[:q]
      @users = @search.result.paginate page: params[:page], per_page: 15
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t ".delete_confirmation"
    redirect_to supervisor_users_path
  end
end
