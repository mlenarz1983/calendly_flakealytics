class HomeController < ApplicationController
  def index
    #todo:
    # in a real-world app, this user would actually be a select-able (i.e. chosen
    # from a client-side dropdown) and that dropdown would be populated with users
    # tied to the current session/auth
    @user = User.first
  end

  # # GET /stats/:user_id
  # def stats
  #   # todo: auth checking (session should have access to user.  determined by db join)
  #   # todo: check cache
  # end

  # POST /user/new
  def new

  end

  # POST /event/new
  def new

  end
end
