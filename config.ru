# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run DemocraticTravelers::Application

require 'rack/cors'
use Rack::Cors do
  allow do
    origins 'iamjohnellis.dev', 'www.iamjohnellis.dev',
            'iamjohnellis.com', 'www.iamjohnellis.com',
            'democratictravelers.dev', 'www.democratictravelers.dev',
            'thedemocratictravelers.com', 'www.thedemocratictravelers.com',
            '127.0.0.1', 'localhost'
    resource '*',
      headers: :any,
      methods: [:get, :post, :delete, :put, :options]
  end
end
