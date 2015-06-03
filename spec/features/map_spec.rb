require 'rails_helper'

feature 'The Map', js: true, vcr: true, record: :new_episodes do
  let!(:state) { create(:state, name: 'California', abbr: 'CA') }
  let!(:current) { create(:location, current: true) }
  let!(:experience) { create(:experience) }

  before { visit map_path }

  scenario 'shows suggestions in the sidebar' do
    expect(page).to have_content experience.name
  end

  scenario 'can show a single experience' do
    visit experience_path(experience)
    expect(page).to have_content experience.name
  end

  scenario 'can show a single user' do
    visit user_path(experience.user)
    sleep 3
    expect(page).to have_content experience.name
  end
end
