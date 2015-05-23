require 'rails_helper'

feature 'The Map', js: true, vcr: true do
  let!(:state) { create(:state, name: 'California', abbr: 'CA') }
  let!(:current) { create(:location, current: true) }
  let!(:experience) { create(:experience) }

  before { visit map_path }

  # scenario 'shows suggestions in the sidebar' do
  #   # sleep 1
  #   # expect(page).to have_content experience.name
  # end
end
