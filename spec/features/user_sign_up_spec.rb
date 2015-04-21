require 'rails_helper'

feature 'User sign up' do
  context '(with invalid attributes)' do
    scenario 'rerenders the sign up page' do
      visit new_user_session_path

      click_button 'Sign Up'

      expect(page).to have_content 'Name can\'t be blank'
    end
  end
end
