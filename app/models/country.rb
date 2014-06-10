class Country < ActiveRecord::Base
  validates_presence_of :name
  validates :code,
            length: { in: 2..3 }
end
