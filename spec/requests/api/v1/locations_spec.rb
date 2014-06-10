require 'spec_helper'

describe 'Locations API' do
  let(:user) { create(:user) }

  before :each do
    5.times { create(:experience) }
  end

  after :each do
    expect(response.status).to be(200)
  end

  describe 'GET /v1/locations' do
    it 'returns all Locations that have Experiences' do
      get api_v1_locations_url, nil, authentication_headers(user)

      expect(json['locations'].length).to eq(5)
    end
  end

  describe 'GET /v1/locations/:id' do
    it 'returns the requested Location' do
      location = create(:location, name: 'Requested Location')

      get api_v1_location_url(location), nil, authentication_headers(user)

      expect(json['locations'][0]['properties']['name'])
        .to eq('Requested Location')
    end
  end

  describe 'GET /v1/locations/current' do
    it 'returns the current Location' do
      create(:location, name: 'Homebase', current: true)

      get current_api_v1_locations_url, nil, authentication_headers(user)

      expect(json['locations'][0]['properties']['name']).to eq('Homebase')
    end
  end
end
