require 'rest-client'

class UsersController < ApplicationController

  protect_from_forgery except: :create

  # POST /users
  def create
    # todo: check logged-in (I believe rails has middleware for this)

    # todo: handle missing api_key param

    # todo: check to see if api is already mapped to a user row in our db.  if so, short-circuit the following
    #       logic.  otherwise, we could be opening ourselves up to an asymetric resource attack (i.e. bad guys
    #       only need to send us an api key and we're stuck waiting on a curl call.)  of course, this could also
    #       be solved by adding rate-limiting that is pinned to the current session.

    # todo: consider queue-ifying this endpoint.  we've got two different synchronous curl calls here.
    #       if Calendly endpoints start slowing down, our servers could end-up with too many concurrent
    #       web connections.  measure to see if this optimization is actually necessary.

    # curl Calendly for user info.  this will be a test of whether the key is legit.  handle the curl library's 401 error.
    # todo: pull curl endpoint url from config file (vs. hard-coding)
    # todo: move curl-ing logic to another class to easier testing (using mocked external endpoints)
    response = RestClient.get(
      "https://calendly.com/api/v1/users/me", 
      headers = {"X-TOKEN" => params['api_key']}
    )

    parsed = JSON.parse(response) 

    # todo: either a) be cool with a single field for 'name' or b) develope a more sophisticated way of splitting names
    user = User.create(
        email_address: parsed["data"]["attributes"]["email"], 
        first_name: parsed["data"]["attributes"]["name"].split(' ')[0], 
        last_name: parsed["data"]["attributes"]["name"].split(' ')[-1], 
        avatar_url: parsed["data"]["attributes"]["avatar"]["url"]
    )

    render json: user

    # todo: handle case where key is invalid/non existant.  return 400

    # todo: grab id from user response.  if users already exists, return info for user (as json).  
    # CAVEAT: check that matching user belongs to current session.  if it does NOT, create mapping between session and user

    # todo: create user using info from curl response.

    # todo: curl Calendly to register webhook.  use mockbin to start with...
  end
end