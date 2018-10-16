class StatsController < ApplicationController
  # GET /stats/:user_id
  def show
    # todo: check logged-in (I believe rails has middleware for this)

    user = User.find(params[:id])

    # todo: handle user not found (404)

    # todo: auth checking (session should have access to user.  determined by db join)
    # todo: check cache

    # users = User.all
    # render json: users

    render json: CancelEvent.getTimeStats(user)
  end
end