class CategoryConnection < ActiveRecord::Base
  belongs_to :category
  belongs_to :connectable, polymorphic: true

  validates :category, :connectable, presence: true
end
