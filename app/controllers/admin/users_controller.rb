class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :find_user, only: [:make_admin]

  def index
    @users = User.all
  end

  def make_admin
    if @user == current_user
      head status: 401
    else
      @user.add_role(:admin)
      redirect_to admin_users_path
    end
  end

  protected

  def find_user
    @user = User.find(params[:id])
  end
end
