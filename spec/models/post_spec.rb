# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  user_id      :integer          default(1), not null
#  body         :text
#  subtitle     :string(255)
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  slug         :string(255)      not null
#  excerpt      :text
#  published    :boolean          default(FALSE), not null
#

require 'rails_helper'

describe Post do
  it 'is created when all attributes are valid' do
    expect(build(:post)).to be_valid
  end

  it 'requires a title' do
    expect(build(:post, title: '')).to be_invalid
  end

  describe '.slug' do
    it 'is set by friendly_id' do
      post = create(:post)
      expect(post).to respond_to(:slug)
      expect(post.slug).to eq('my-awesome-title')
    end

    it 'must be unique' do
      post1 = create(:post, id: 1)
      post2 = create(:post, id: 2)
      expect(post1.slug).to_not eq(post2.slug)
    end
  end

  it 'must have a user' do
    expect(build(:post, user_id: nil)).to be_invalid
  end

  describe '#published?' do
    it 'returns true when #published is set to true and published_at is in the past' do
      post = build(:post, published_at: 3.days.ago, published: true)
      expect(post.published?).to eq(true)
    end

    it 'returns false when #published is set to false' do
      post = build(:post, published_at: 3.days.ago, published: false)
      expect(post.published?).to eq(false)
    end

    it 'returns true when #published is set to true and published_at is in the future' do
      post = build(:post, published_at: 3.days.from_now, published: true)
      expect(post.published?).to eq(false)
    end
  end

  describe '#cover' do
    it 'returns an asset url' do
      asset = create(:image, cover: true)
      post = create(:post)
      post.assets << asset

      expect(post.cover).to eq asset.asset.url
    end
  end
end
