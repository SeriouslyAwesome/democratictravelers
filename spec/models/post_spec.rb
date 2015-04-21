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
      post1 = create(:post)
      post2 = create(:post, id: 2)
      expect(post1.slug).to_not eq(post2.slug)
    end
  end

  it 'must have a user' do
    expect(build(:post, user_id: nil)).to be_invalid
  end
end
