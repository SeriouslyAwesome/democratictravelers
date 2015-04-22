module FeatureMacros
  def login_admin
    @admin = create(:user)
    @admin.add_role(:admin)

    visit new_user_session_path

    within '#sign-in' do
      fill_in 'user[email]', with: @admin.email
      fill_in 'user[password]', with: @admin.password
      click_button 'Sign In'
    end
  end

  def login_user
    @user = create(:user)

    visit new_user_session_path

    within '#sign-in' do
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'Sign In'
    end
  end
end
