require 'rails_helper'

describe Suggestion do
  describe '#submit' do
    before :each do
      @user = create(:user)
      create(:state, abbr: 'CA', name: 'California')
      @suggestion = build(:suggestion, user_id: @user.id)
      @suggestion.submit
    end

    it 'creates an Experience record' do
      expect(Experience.all.count).to eq(1)
    end

    it 'finds or creates a Location record' do
      expect(Location.all.count).to eq(1)
    end

    it 'associates the Experience with the Location' do
      expect(Experience.first.location).to eq(Location.first)
    end
  end
end
