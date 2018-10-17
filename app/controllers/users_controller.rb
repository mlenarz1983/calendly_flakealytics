class UsersController < ApplicationController
  # POST /users
  def new
    # todo: check logged-in (I believe rails has middleware for this)

    # todo: curl Calendly for user info.  this will be a test of whether the key is legit

    # todo: handle case where key is invalid/non existant.  return 400

    # todo: grab id from user response.  if users already exists, return info for user (as json).  
    # CAVEAT: check that matching user belongs to current session.  if it does NOT, create mapping between session and user

    # todo: create user using info from curl response.

    # todo: curl Calendly to register webhook.  use mockbin to start with...
  end
end