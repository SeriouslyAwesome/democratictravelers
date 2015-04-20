[![Circle CI](https://circleci.com/gh/SeriouslyAwesome/democratictravelers.svg?style=svg)](https://circleci.com/gh/SeriouslyAwesome/democratictravelers)
[![Code Climate](https://codeclimate.com/github/SeriouslyAwesome/democratictravelers.png)](https://codeclimate.com/github/SeriouslyAwesome/democratictravelers)

#The Democratic Travelers v4.0

This is the official code repository for [TheDemocraticTravelers.com](http://www.thedemocratictravelers.com), a travel blog where visitors submit their suggestions of places/events for John and Laura to visit (and for [Shane](https://github.com/shiftshane) to visit them while they're visiting things), and others vote on the suggestions.

##Overview
It's a [Ruby on Rails](http://rubyonrails.org) (4.1) application on the back-end, with [Mapbox](https://www.mapbox.com/) & the Google Places API powering the suggestion map. Styling is done with a glass of [Bourbon](http://bourbon.io), [Neat](http://neat.bourbon.io), with a dash of [Bitters](http://bitters.bourbon.io).

##Prerequisites
1. You'll need Redis installed: `brew install redis`
2. You'll need PostgreSQL installed too.

##Getting Started
Running `bundle install` and `rake db:migrate` should get your gems and DB setup. Then make sure Redis is running (`redis-server`) and fire up Sidekiq with `bundle exec sidekiq`.

Guard is implemented, and can be fired up with `bundle exec guard`, which will automatically run relevant specs, as well as Rubocop. If you don't like that, you can always `bundle exec rspec`.

##Notes
This is a labor of love and always a work-in-progress. If you see something wrong or that could be better, please feel free to open an issue or a pull request.
