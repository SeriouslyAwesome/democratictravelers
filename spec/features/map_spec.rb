require 'rails_helper'

feature 'The Map', js: true, vcr: true, record: :new_episodes do
  let!(:state) { create(:state, name: 'California', abbr: 'CA') }
  let!(:current) { create(:location, current: true) }
  let!(:experience) { create(:experience) }

  scenario 'shows suggestions in the sidebar' do
    visit map_path
    expect(page).to have_content experience.name
  end

  scenario 'can show a single experience' do
    visit experience_path(experience)
    expect(page).to have_content experience.name
  end

  scenario 'can show a single user' do
    visit user_path(experience.user.username)
    expect(page).to have_content experience.name
  end

  scenario 'allows a visitor to make a suggestion' do
    user = create(:user)
    visit map_path
    click_on 'Add a Suggestion'
    click_on 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Sign In'

    fill_in 'location-search', with: 'Palo Alto, CA'
    sleep 1
    within('.pac-container') { first('.pac-item').click }
    fill_in 'What should we do there?', with: 'Get a Job'
    fill_in 'Why should we do it?', with: 'For money, duh.'
    click_on 'Suggest It'

    expect(page).to have_content 'Thanks for the tip!'
    expect(Experience.find_by(name: 'Get a Job')).to be
    expect(Location.find_by(city: 'Palo Alto')).to be
  end
end
