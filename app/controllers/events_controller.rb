class EventsController < ApplicationController
  # this is an external API, so we don't need this here
  protect_from_forgery except: :create

  # POST /events
  def create
    # no need to check session/logged-in status since this endpoint is being hit by a calendly server

    # todo: consider putting the following logic behind some sort of queue.  it's probably okay to keep this endpoint
    #       synchronous in the beginning, but if performance issues are discovered, a queue may be a panacea.

    # todo: rate-limit by sender IP (this should probably live in middleware or at the infrastructure level)

    # todo: rate-limit by event-type.  some tuneing/sanity-checking is needed here.  i.e. a really popular
    #       event-type may have a lot of activity and we don't want to throw-away good data.  I would put the rate
    #       in some sort of easily-updatable config file and start with e.g. < 5 events per minute.

    # todo: check structure/values of POST body

    # todo: check that user exists in our db.  if it does not, that means someone else has registered this
    #       endpoint as a webhook.  in that case, we're not interested in the data.  so... get outta here.

    # todo: ignore created event

    # todo: sanitize string fields (against JS injection)

    # todo: create event-type if it doesn't already exist

    # todo: check for duplicates (in case the Calendly webhook is having issues and re-sending data that we've already received )

    # todo: persist event

  end
end