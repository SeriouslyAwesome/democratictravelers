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
