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

  scenario 'can show a single user', focus: true do
    visit user_path(experience.user.username)
    expect(page).to have_content experience.name
  end
end
