FactoryGirl.define do
  factory :post do
    title 'My Awesome Title'
    user
    excerpt 'This is the excerpt.'
    body 'This is an awesome post. Here\'s the content.'
    subtitle 'All about the post'
    published_at 2.days.ago
    published true

    after(:build) do |post|
      asset = create(:image)
      post.assets << asset
    end
  end
end
