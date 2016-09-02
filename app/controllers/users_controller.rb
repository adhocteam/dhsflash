class UsersController < ApplicationController
  before_action :authenticate_user!

  def search
    if params[:search].present?
      render json: User.where('username LIKE ?', "%#{params[:search]}%").where.not(id: current_user.id)
    else
      head 400
    end
  end

  def show
    @user = User.find(params[:id])

    @received = Kudo.where(recipient_id: @user.id)
    @sent = Kudo.where(creator_id: @user.id)

    # TODO: where("creator_id = ? or recipient_id = ?", [@user.id, @user.id]) when we need to limit/page
    @kudos = @sent | @received
    @kudos.sort! { |k1, k2| k1.created_at <=> k2.created_at }
    render :show
  end
end
