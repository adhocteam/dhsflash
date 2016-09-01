class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :find_user, only: [:destroy, :make_admin, :remove_admin]
  before_action :block_current_user, only: [:make_admin, :remove_admin]

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  def make_admin
    @user.add_role(:admin)
    redirect_to admin_users_path
  end

  def remove_admin
    @user.remove_role(:admin)
    redirect_to admin_users_path
  end

  protected

  def find_user
    @user ||= User.find(params[:id])
  end

  def block_current_user
    if find_user == current_user
      head status: 401
    end
  end
end
