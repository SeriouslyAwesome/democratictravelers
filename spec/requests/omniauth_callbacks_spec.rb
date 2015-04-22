require 'rails_helper'

describe "GET '/auth/facebook/callback'" do
  context '(with valid credentials)' do
    before(:each) do
      valid_facebook_login_setup
      post "/auth/facebook/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    it "should redirect to the map" do
      expect(response).to redirect_to map_path
    end
  end

  context '(with invalid credentials)' do
    before(:each) do
      invalid_facebook_login_setup
      post "/auth/facebook/callback"
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

    it "should redirect to root" do
      expect(response).to redirect_to root_path
    end
  end
end
