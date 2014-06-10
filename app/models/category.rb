class Category < ActiveRecord::Base
  belongs_to :connectable, polymorphic: true
  has_many :categorizations, dependent: :destroy
  has_many :posts, through: :categorizations

  default_scope { order('position ASC') }

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name

  def should_generate_new_friendly_id?
    new_record?
  end
end
