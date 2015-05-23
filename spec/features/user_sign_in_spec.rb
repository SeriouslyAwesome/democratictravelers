require 'rails_helper'

feature 'User sign in', vcr: true, record: :new_episodes do
  let!(:current) { create(:location, current: true) }
  let!(:user) { create(:user) }

  context '(via sign in/up page)' do
    before { visit new_user_session_path }

    context '(with valid credentials)' do
      scenario 'redirects the user to the map' do
        within '#sign-in' do
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: user.password
          click_button 'Sign In'
        end

        expect(current_path).to eq(map_path)
      end
    end

    context '(with invalid credentials)' do
      scenario 'displays error message' do
        within '#sign-in' do
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: 'incorrectpassword'
          click_button 'Sign In'
        end

        expect(page).to have_content I18n.t('devise.failure.invalid')
      end
    end
  end

  context '(via the Map)', js: true do
    before do
      visit map_path
      click_on 'Add a Suggestion'
      click_on 'Sign in'
    end

    context '(with valid credentials)' do
      scenario 'works' do

        within '#sign-in' do
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: user.password
          click_button 'Sign In'
        end

        expect(page).to have_content 'Welcome back!'
      end
    end

    context '(with invalid credentials)' do
      scenario 'displays error message' do
        within '#sign-in' do
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]', with: 'incorrectpassword'
          click_button 'Sign In'
        end
        expect(page).to have_content I18n.t('devise.failure.invalid')
      end
    end
  end
end
