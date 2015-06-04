[![Circle CI](https://circleci.com/gh/SeriouslyAwesome/democratictravelers/tree/v5.svg?style=svg)](https://circleci.com/gh/SeriouslyAwesome/democratictravelers/tree/v5)
[![Code Climate](https://codeclimate.com/github/SeriouslyAwesome/democratictravelers/badges/gpa.svg)](https://codeclimate.com/github/SeriouslyAwesome/democratictravelers)
[![Test Coverage](https://codeclimate.com/github/SeriouslyAwesome/democratictravelers/badges/coverage.svg)](https://codeclimate.com/github/SeriouslyAwesome/democratictravelers)

#The Democratic Travelers v4.5

This is the official code repository for [TheDemocraticTravelers.com](http://www.thedemocratictravelers.com), a travel blog where visitors submit their suggestions of places/events for John and Laura to visit (and for [Shane](https://github.com/shiftshane) to visit them while they're visiting things), and others vote on the suggestions.

##Overview
This project is a [Ruby on Rails](http://rubyonrails.org) application that features an interactive map powered by a JSON API rendered with [Handlebars](http://handlebarsjs.com) templates and supported by token authentication, [Mapbox](https://www.mapbox.com/developers/), [Leaflet](http://leafletjs.com), and the [Google Places API](https://developers.google.com/places/), all written in object-oriented [Coffeescript](http://coffeescript.org) and [jQuery](http://jquery.com). It's also got a full blog system that hooks into the data on the map to notify users by email when we've written about their submissions. Other goodies include social sign-in with [OAuth](http://oauth.net), guest user accounts, plus [Mailchimp](https://apidocs.mailchimp.com) and [Instagram API](https://instagram.com/developer/) integration. It's backed by a PostgreSQL database, and tuned for performance by taking advantage of background workers with [Redis](https://redistogo.com) and [Sidekiq](http://sidekiq.org) to send emails and process image uploads, along with JSON caching, fragment caching, asset minification & compression, and eager loading. I also designed the front-end and styled it with [Bourbon](http://bourbon.io), [Neat](http://neat.bourbon.io), and [Bitters](http://bitters.bourbon.io), with typography that falls on a proper baseline grid.

##Prerequisites
1. You'll need Redis installed: `brew install redis`
2. You'll need PostgreSQL installed too.

##Getting Started
Running `bundle install` and `rake db:migrate` should get your gems and DB setup. Then make sure Redis is running (`redis-server`) and fire up Sidekiq with `bundle exec sidekiq`.

Guard is implemented, and can be fired up with `bundle exec guard`, which will automatically run relevant specs, as well as Rubocop. If you don't like that, you can always `bundle exec rspec`.

##Notes
This is a labor of love and always a work-in-progress. If you see something wrong or that could be better, please feel free to open an issue or a pull request.

##Server Monitor
<iframe src="https://rpm.newrelic.com/public/charts/9CmNUngyt13" width="728" height="300" scrolling="no" frameborder="no"></iframe>
