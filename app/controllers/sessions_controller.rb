class SessionsController < Devise::SessionsController
  def create
    if request.xhr?
      resource = warden.authenticate!(
        scope: resource_name,
        recall: "#{controller_path}#failure"
      )
      sign_in_and_redirect(resource_name, resource)
    else
      super
    end
  end

  def sign_in_and_redirect(resource_or_scope, resource = nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    sign_out_link = view_context
      .link_to 'Sign out', destroy_user_session_path, method: :delete

    render json: {
      success: true,
      greeting: "Hey #{resource.first_name}! Welcome back! #{sign_out_link}",
      api_key: resource.authentication_token, user_id: resource.uuid
    }
  end

  def failure
    render json: { success: false, errors: I18n.t('devise.failure.invalid') }
  end
end
