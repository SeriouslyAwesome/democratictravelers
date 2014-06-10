class API::V1::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, only: :create
  include Devise::Controllers::Helpers

  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    resource.save!
    render json: { auth_token: resource.authentication_token }
  end

  def destroy
    sign_out(resource_name)
  end
end
