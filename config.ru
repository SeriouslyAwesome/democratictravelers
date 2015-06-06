# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run DemocraticTravelers::Application

require 'rack/cors'
use Rack::Cors do
  allow do
    origins 'iamjohnellis.com', 'iamjohnellis.dev',
            'www.thedemocratictravelers.com'
    resource '*',
      headers: :any,
      methods: [:get, :post, :delete, :put, :options]
  end
end
