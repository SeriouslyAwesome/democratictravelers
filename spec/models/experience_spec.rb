# == Schema Information
#
# Table name: experiences
#
#  id          :integer          not null, primary key
#  location_id :integer          not null
#  name        :string(255)      not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  distance    :float
#  votes_cache :integer          default(0), not null
#  slug        :string(255)
#  done        :boolean          default(FALSE), not null
#

require 'rails_helper'

describe Experience do
  describe 'validations' do
    it 'requries a name' do
      expect(build(:experience, name: nil)).to be_invalid
      expect(build(:experience, name: '')).to be_invalid
    end

    it 'requires a location' do
      expect(build(:experience, location: nil)).to be_invalid
    end
  end

  describe 'callbacks' do
    before :each do
      @user = create(:user)
      @experience = create(:experience, user: @user)
    end

    it 'sets distance before create' do
      create(:location, current: true)
      expect(@experience.distance).to be_a(Float)
    end

    it 'is auto-up-voted upon creation' do
      expect(@experience.reputation_for(:votes).to_i).to eq(1)
      expect(@experience.votes_cache).to eq(@experience.reputation_for(:votes))
    end

    it 'maintains cached vote count' do
      @experience.downvote(@user)
      expect(@experience.votes_cache).to eq(@experience.reputation_for(:votes))
    end
  end

  describe 'instance methods' do
    before :each do
      @user = create(:user)
      @experience = create(:experience, user: @user)
      @visitor = create(:user)
    end

    it '#upvote(user) increases vote count by 1' do
      @experience.upvote(@visitor)
      expect(@experience.votes_cache).to eq(@experience.reputation_for(:votes))
      expect(@experience.votes_cache).to eq(2)
    end

    it '#upvote(user) decreases vote count by 1' do
      @experience.downvote(@visitor)
      expect(@experience.votes_cache).to eq(@experience.reputation_for(:votes))
      expect(@experience.votes_cache).to eq(0)
    end
  end
end
