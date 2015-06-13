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

class CategoryConnection < ActiveRecord::Base
  belongs_to :category
  belongs_to :connectable, polymorphic: true

  validates :category, :connectable, presence: true
end
