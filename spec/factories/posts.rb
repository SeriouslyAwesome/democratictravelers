FactoryGirl.define do
  factory :post do
    title 'My Awesome Title'
    user_id 1
    body 'This is an awesome post. Here\'s the content.'
    subtitle 'All about the post'
    published_at '2012-10-12 00:17:59'
    comment_count 1
    attachment_count 1
    format 'photo_essay'
  end
end
