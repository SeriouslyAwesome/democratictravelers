source 'https://rubygems.org'
ruby '2.1.5'
#ruby-gemset=democratictravelers

# RAILS CORE
gem 'rails', '~>4.1.1'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder'

# SERVER/MONITORING
gem 'pg'
gem 'unicorn'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'rack-cors', require: 'rack/cors' # For cross-domain Ajax requests
gem 'hirefire-resource'

# ASSETS
gem 'bourbon'
gem 'neat'
gem 'bitters'
gem 'yui-compressor'
gem 'font-awesome-rails'
gem 'handlebars_assets'
gem 'jquery-ui-rails'
gem 'yajl-ruby', require: 'yajl'
gem 'heroku_rails_deflate', group: :production

# FUNCTIONALITY
gem 'friendly_id'
gem 'activerecord-reputation-system', '~> 2.0',
                                      git: 'git://github.com/NARKOZ/activerecord-reputation-system.git',
                                      branch: 'rails4'
gem 'geocoder'

# INTERFACE
gem 'nested_form'
gem 'will_paginate'
gem 'socialization'
gem 'redcarpet'
gem 'kaminari'
gem 'jquery-fileupload-rails'

# AUTHENTICATION / AUTHORIZATION
gem 'devise'
gem 'rolify'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'devise_marketable'

# FILE HANDLING
gem 'carrierwave'
gem 'mini_magick'
gem 'carrierwave-aws'

# EXTERNAL APIs
gem 'gibbon' # Mailchimp

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end

# DEVELOPMENT
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'figaro' # ENV variables made easier
  gem 'powder' # Local server sugar
  gem 'rack-mini-profiler' # Query metrics
  gem 'thor' # Used for Heroku DB cloning
  gem 'rubocop' # Keeping the streets clean of Ruby crimes
  gem 'rails_best_practices' # Like rubocop, but for rails
  gem 'guard-rails_best_practices'
  gem 'quiet_assets' # Shut the hell up, assets
end

# TESTING
group :development, :test do
  gem 'spring-commands-rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'

  # Guard
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'guard-rubocop' # Check each file upon save
  # gem 'rb-fsevent', require: false if `uname` =~ /Darwin/

  # Other testing helpers
  gem 'fakeweb'
  gem 'vcr'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'capybara'
  gem 'poltergeist'
end
