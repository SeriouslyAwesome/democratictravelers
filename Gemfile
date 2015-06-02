source 'https://rubygems.org'
ruby '2.2.2'

gem 'activerecord-reputation-system', '~> 2.0',
  git: 'git://github.com/NARKOZ/activerecord-reputation-system.git',
  branch: 'rails4'
gem 'bitters'
gem 'bourbon'
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'coffee-rails'
gem 'devise'
gem 'devise_marketable'
gem 'font-awesome-sass', '~> 4.3.0'
gem 'friendly_id'
gem 'geocoder'
gem 'gibbon' # Mailchimp
gem 'handlebars_assets', '~> 0.16.0'
gem 'hirefire-resource'
gem 'jbuilder'
gem 'jquery-fileupload-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'kaminari'
gem 'mini_magick'
gem 'neat'
gem 'nested_form'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'pg'
gem 'rack-cors', require: 'rack/cors' # For cross-domain Ajax requests
gem 'rails', '~>4.2'
gem 'redcarpet'
gem 'rolify'
gem 'sass-rails'
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'socialization'
gem 'uglifier'
gem 'unicorn'
gem 'will_paginate'
gem 'yajl-ruby', require: 'yajl'
gem 'yui-compressor'

group :production do
  gem 'heroku_rails_deflate'
  gem 'newrelic_rpm'
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'figaro' # ENV variables made easier
  gem 'powder' # Local server sugar
  gem 'quiet_assets' # Shut the hell up, assets
  gem 'rack-mini-profiler' # Query metrics
  gem 'rails_best_practices' # Like rubocop, but for rails
  gem 'rubocop' # Keeping the streets clean of Ruby crimes
  gem 'spring'
  gem 'thor' # Used for Heroku DB cloning
end

group :development, :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'capybara-webkit', '~>1.4.0'
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'launchy'
  gem 'poltergeist'
  gem 'pry'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', '~> 0.9.0', require: false
  gem 'spring-commands-rspec'
  gem 'vcr'
end

group :test do
  gem 'webmock'
end
