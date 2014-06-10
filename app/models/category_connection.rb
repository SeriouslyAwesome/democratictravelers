class CategoryConnection < ActiveRecord::Base
  belongs_to :category
  belongs_to :connectable, polymorphic: true

  validates_presence_of :category_id,
                        :connectable_id,
                        :connectable_type
end
