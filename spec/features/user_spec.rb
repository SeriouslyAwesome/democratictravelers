require 'rails_helper'

feature 'User profile', js: true, vcr: true, record: :new_episodes do
  let!(:current) { create(:location, current: true) }
  let!(:user) { create(:user) }

  scenario 'shows the map' do
    visit user_path(user)
    expect(page).to have_content('ADD A SUGGESTION')
  end
end
