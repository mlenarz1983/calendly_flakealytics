require 'rest-client'

class UsersController < ApplicationController

  protect_from_forgery except: :create

  # POST /users
  def create
    # todo: check logged-in (I believe rails has middleware for this)

    # todo: check to see if api is already mapped to a user row in our db.  if so, short-circuit the following
    #       logic.  otherwise, we could be opening ourselves up to an asymetric resource attack (i.e. bad guys
    #       only need to send us an api key and we're stuck waiting on a curl call.)  of course, this could also
    #       be solved by adding rate-limiting that is pinned to the current session.

    # todo: consider queue-ifying this endpoint.  we've got two different synchronous curl calls here.
    #       if Calendly endpoints start slowing down, our servers could end-up with too many concurrent
    #       web connections.  measure to see if this optimization is actually necessary.

    # curl Calendly for user info.  this will be a test of whether the key is legit.  handle the curl library's 401 error.
    # require 'net/http'
    # uri = URI.parse("https://calendly.com/api/v1/echo")

    # render json: params['api_key']

    response = RestClient.get(
      "https://calendly.com/api/v1/echo", 
      headers = {"X-TOKEN" => params['api_key']}
    )

    render json: response

    # todo: handle case where key is invalid/non existant.  return 400

    # todo: grab id from user response.  if users already exists, return info for user (as json).  
    # CAVEAT: check that matching user belongs to current session.  if it does NOT, create mapping between session and user

    # todo: create user using info from curl response.

    # todo: curl Calendly to register webhook.  use mockbin to start with...
  end
end