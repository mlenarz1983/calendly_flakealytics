# What is this?
======

This is a toy project I put together to demonstrate a potential use of Calendly's [public API](https://developer.calendly.com/).  Calendly is a service which allows you to share your schedule and give invitees the ability to reserve a part of your day.  Calendly's current API allows you to subscribe to these reservations as well as the cancellation of those reservations.  This application is meant to give some insight into the trends of cancellations (i.e. flakiness).  If this were a real-world application, I'd look into actual trends that might be useful to Calendly; this application just looks are silly trends.

This front-end of this application is written in plain javascript/html/css and the back-end is written in Ruby On Rails.

# Disclaimer
======

This is the first time I've ever written anything in ruby or rails.  Please don't look to this an an example of RoR best-practices.  What you'll find here - on the back-end, anyway - is the result of just-in-time learning and examples adapted from tutorials.  I tried to do the right thing where possible. 

# Setup
======

In your local dev environment, make sure you have the latest version of ruby and the Rails framework.  Once you've got that set-up, it should be as simple as running

```
rake db:drop db:create db:migrate
```

This will seed your local database with simulated, demo data.  After that, start your local rails server and you should see a dashboard similar to the screenshot above.

If you want to use this in a production environment, there's some extra work you need to do.  In the [events controller](../app/controllers/events_controller.rb), you'll notice that the webhook is empty.  It's mostly just data-access logic that's missing.  You'll also need to update the webhook url that is registered within users/create.

# Highlights
======

* [events controller](../app/controllers/events_controller.rb): this is all pseudocode, but I believe it demonstrates some higher-level system design.
* [cancel_event model](../app/models/cancel_event.rb): basic SQL to collect flakiness statistics
* [index view](../app/views/home/index.html.erb): this is mostly boilerplate chart config and the glue necessary to tie it to backend endpoints

# Missing Pieces
======

* as mentioned above, the webhook endpoint is currently still in the form of pseudocode.  The missing code is mostly boilerplate and I thought it would be more instructive to write-out design considerations.
* auth-management.  the application currently does not have sessions/logins and as-such anyone can see analytics for any user.  we wouldn't want that in the real-world
* switching between users in the database.  the app currently just loads the first user in the database
* better UI.  I'm not a designer.  You'll see that I took a few short-cuts in terms of UX... 

# Dependencies
======

* [chart.js](https://www.chartjs.org/)

# Testing
======

this project currently contains no tests.  If this were a non-toy project, I would add:

## unit tests
* the two methods in [cancel_event model](../app/models/cancel_event.rb)
* move some of the logic from users/create controller into the users model and use mocked endpoints to test the various error conditions + edge cases from Calendly's API

## functional tests
* a bare-bones selenium/protractor test to seed a local db and verify that the charts are successfully generated