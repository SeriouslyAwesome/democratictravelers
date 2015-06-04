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
