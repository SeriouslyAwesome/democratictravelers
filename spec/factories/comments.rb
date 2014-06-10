FactoryGirl.define do
  factory :comment do
    commentable_id 1
    commentable_type 'Post'
    title 'This is my comment!'
    body 'The Democratic travelers are the best in the world!'
    subject 'A Subject'
    user_id 1
    parent_id 'NULL'
  end
end
