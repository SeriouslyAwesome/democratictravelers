require 'rails_helper'

feature 'Admin area', js: true, vcr: true do
  let!(:state) { create(:state, name: 'Nevada', abbr: 'NV') }

  before do
    login_admin
  end

  scenario 'allows me to cross off a state' do
    check "state_#{state.id}"
    sleep 1
    expect(state.reload.done).to eq(true)
  end

  scenario 'allows me to set my current location' do
    create(:state, name: 'Nevada', abbr: 'NV')

    fill_in 'admin-location-search', with: 'Las Vegas, Nevada'
    within '.pac-container' do
      first('.pac-item').click
    end

    click_button 'Set'
    sleep 3
    expect(Location.last.current).to eq(true)
  end
end

