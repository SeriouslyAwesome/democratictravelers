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

class Category < ActiveRecord::Base
  belongs_to :connectable, polymorphic: true
  has_many :categorizations, dependent: :destroy
  has_many :posts, through: :categorizations

  default_scope { order('position ASC') }

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true

  def should_generate_new_friendly_id?
    new_record?
  end
end
