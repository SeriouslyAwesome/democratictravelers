# The Democratic Travelers v5.0

[![Hypercommit](https://img.shields.io/badge/Hypercommit-DB2475)](https://hypercommit.com/democratictravelers)

This is the official code repository for [TheDemocraticTravelers.com](http://www.thedemocratictravelers.com), a travel blog where visitors submit their suggestions of places/events for John and Laura to visit (and for [Shane](https://github.com/shiftshane) to visit them while they're visiting things), and others vote on the suggestions.

## Overview
This project is a [Ruby on Rails](http://rubyonrails.org) 7.2 application running on Ruby 3.2. It features an interactive map powered by a JSON API rendered with vanilla JavaScript templates and supported by token authentication, [Mapbox](https://www.mapbox.com/developers/), [Leaflet](http://leafletjs.com), and the [Google Places API](https://developers.google.com/places/), written in [jQuery](http://jquery.com). It's also got a full blog system that hooks into the data on the map to notify users by email when we've written about their submissions. Other goodies include social sign-in with [OAuth](http://oauth.net), guest user accounts, plus [Mailchimp](https://apidocs.mailchimp.com) and [Instagram API](https://instagram.com/developer/) integration. It's backed by a PostgreSQL database, and tuned for performance by taking advantage of background workers with [Redis](https://redistogo.com) and [Sidekiq](http://sidekiq.org) to send emails and process image uploads, along with JSON caching, fragment caching, asset minification & compression, and eager loading. The front-end is styled with [Bourbon](http://bourbon.io), [Neat](http://neat.bourbon.io), and [Bitters](http://bitters.bourbon.io), with typography that falls on a proper baseline grid. The app is served by [Puma](https://puma.io).

## Prerequisites
1. Ruby 3.2.6
2. PostgreSQL
3. Redis: `brew install redis`

## Getting Started
Running `bundle install` and `bin/rails db:migrate` should get your gems and DB setup. Then make sure Redis is running (`redis-server`) and fire up Sidekiq with `bundle exec sidekiq`.

To run the test suite: `bundle exec rspec`.

## Notes
This is a labor of love and always a work-in-progress. If you see something wrong or that could be better, please feel free to open an issue or a pull request.
