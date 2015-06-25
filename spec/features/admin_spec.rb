require 'rails_helper'

feature 'Admin area', js: true, vcr: true, record: :new_episodes do
  let!(:current) { create(:location, current: true) }
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
    sleep 1
    within('.pac-container') { first('.pac-item').click }
    sleep 6

    click_button 'Set'
    sleep 1
    expect(Location.order('updated_at DESC').first.current).to eq(true)
  end
end
