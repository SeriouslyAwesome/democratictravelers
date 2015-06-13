# == Schema Information
#
# Table name: category_connections
#
#  id               :integer          not null, primary key
#  category_id      :integer
#  connectable_id   :integer
#  connectable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :category_connection, class: 'CategoryConnection' do
    category_id 1
    connectable_id 1
    connectable_type 'Posts'
  end
end
