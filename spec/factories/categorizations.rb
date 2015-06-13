# == Schema Information
#
# Table name: categorizations
#
#  post_id     :integer
#  category_id :integer
#

FactoryGirl.define do
  factory :categorization, class: 'Categorizations' do
    id ''
    post_id 1
    category_id 1
  end
end
