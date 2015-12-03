class UsersController < ApplicationController
  def index
    @users = User.trainees.paginate page: params[:page], per_page: 15
  end
end
