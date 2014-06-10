[![Code Climate](https://codeclimate.com/github/SeriouslyAwesome/democratictravelers.png)](https://codeclimate.com/github/SeriouslyAwesome/democratictravelers)

#The Democratic Travelers v4.0

This is the official code repository for theDemocraticTravelers.com, a travel blog where visitors submit their suggestions of places/events for John and Laura to visit (and for [Shane](https://github.com/shiftshane) to visit them while they're visiting things), and others vote on the suggestions.

##Overview
It's a [Ruby on Rails](http://rubyonrails.org) (4.1) application on the back-end, with [Mapbox](https://www.mapbox.com/) & the Google Places API powering the suggestion map. Styling is done with a glass of [Bourbon](http://bourbon.io), [Neat](http://neat.bourbon.io), with a dash of [Bitters](http://bitters.bourbon.io).

##The Stack

* **Ruby 2.1**
* **Rails 4.1**
* **PostgreSQL**
* **Heroku** single dyno with multiple Unicorn processes.
* **Sidekiq, Redis, and HireFire.io** to handle jobs like image uploads and emails on worker dynos with minimal cost.

##Other Major Components
* **Devise + OmniAuth + Rolify** for authentication/authorization
* **Carrierwave + AWS S3** for uploads and storage
* **RSpec + FactoryGirl** for testing
* **JBuilder + Yajl** for API responses

##Notes
This is a labor of love and always a work-in-progress. If you see something wrong or that could be better, please feel free to open an issue or a pull request.