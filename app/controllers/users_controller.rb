class UsersController < ApplicationController
  before_action :authenticate_user!

  def search
    render json: User.where('username LIKE ?', "%#{params[:search]}%")
  end
end
