class Country < ActiveRecord::Base
  validates :name, presence: true
  validates :code, length: { in: 2..3 }
end
