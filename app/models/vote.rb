class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :user_id, presence: true
  validates :votable_id, presence: true
  validates :votable_type, presence: true
  validates :value, presence: true, inclusion: { in: [-1, 1] }
  validates :user_id, uniqueness: { scope: [:votable_id, :votable_type] }
end
