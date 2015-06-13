# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  post_count  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string(255)
#  position    :integer          default(0), not null
#

FactoryGirl.define do
  factory :category do
    name 'Category Name'
    description 'A generic category.'
    post_count 1
  end
end
