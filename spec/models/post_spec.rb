require 'spec_helper'

describe Post do
  it 'is created when all attributes are valid' do
    build(:post).should be_valid
  end

  it 'requires a title' do
    build(:post, title: '').should be_invalid
  end

  describe '.slug' do
    it 'is set by friendly_id' do
      post = create(:post)
      post.should respond_to(:slug)
      post.slug.should eq('my-awesome-title')
    end

    it 'must be unique' do
      post1 = create(:post)
      post2 = create(:post, id: 2)
      post1.slug.should_not eq(post2.slug)
    end
  end

  it 'must have a user' do
    build(:post, user_id: nil).should be_invalid
  end
end
