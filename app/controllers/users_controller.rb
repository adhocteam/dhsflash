class UsersController < ApplicationController
  before_action :authenticate_user!

  def search
    if params[:search].present?
      render json: User.where('username LIKE ?', "%#{params[:search]}%").where.not(id: current_user.id)
    else
      head 400
    end
  end
end
