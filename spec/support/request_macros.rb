module RequestMacros
  def login_admin
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    @admin = create(:user)
    @admin.add_role(:admin)
    sign_in @admin # Using factory girl as an example
  end

  def login_user
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = create(:user)
    # user.confirm! # or set a confirmed_at inside the factory.
    # Only necessary if you are using the confirmable module
    sign_in @user
  end

  def authentication_headers(user)
    {
      'X-API-KEY' => "#{user.authentication_token}",
      'X-USER-ID' => "#{user.uuid}"
    }
  end

  def json
    @json ||= JSON.parse(response.body)
  end
end
