require 'rest-client'

class UsersController < ApplicationController

  protect_from_forgery except: :create

  # POST /users
  def create
    # todo: check logged-in (I believe rails has middleware for this)

    # todo: handle missing api_key param

    api_key = params['api_key']

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
    user_response = RestClient.get(
      "https://calendly.com/api/v1/users/me", 
      headers = {"X-TOKEN" => api_key}
    )

    # todo: handle case where key is invalid/non existant.  return 400

    user_response_parsed = JSON.parse(user_response) 

    # todo: grab id from user response.  if users already exists, return info for user (as json).  
    # CAVEAT: check that matching user belongs to current session.  if it does NOT, create mapping between session and user

    # create user using info from curl response.
    # todo: either a) be cool with a single field for 'name' or b) develope a more sophisticated way of splitting names
    user = User.create(
        email_address: user_response_parsed["data"]["attributes"]["email"], 
        first_name: user_response_parsed["data"]["attributes"]["name"].split(' ')[0], 
        last_name: user_response_parsed["data"]["attributes"]["name"].split(' ')[-1], 
        avatar_url: user_response_parsed["data"]["attributes"]["avatar"]["url"],
        api_key: api_key
    )

    # POST to Calendly to register webhook.  we're only interested in the cancel event.  use mockbin to start with,
    # since this application isn't being deployed anywhere public...
    # todo: pull curl endpoint url from config file (vs. hard-coding)
    register_webhook_payload = {
      url: 'https://mockbin.org/bin/07dfd238-f79b-4587-b12f-0a12a9c11617', 
      'events[]': 'invitee.canceled'
    }

    # todo: handle 409: conflict error (webhook has already been registered for this user/api_key)
    register_webhook_response = RestClient.post(
      "https://calendly.com/api/v1/hooks", 
      register_webhook_payload,
      headers = {"X-TOKEN" => api_key}
    )

    render json: user
  end
end