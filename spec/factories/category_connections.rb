FactoryGirl.define do
  factory :category_connection, class: 'CategoryConnection' do
    category_id 1
    connectable_id 1
    connectable_type 'Posts'
  end
end
