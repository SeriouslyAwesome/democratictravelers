# United States of 'Murica
class State < ActiveRecord::Base
  default_scope { order('name ASC') }
  has_many :locations
  has_many :experiences, through: :locations
  # attr_accessible:abbr, :name, :done

  validates :name,
            presence: true,
            format: { with: /\A[a-zA-Z ]+\z/ }

  validates :abbr,
            presence: true,
            format: { with: /\A[a-zA-Z]+\z/ },
            length: { is: 2 }

  scope :done, -> { where(done: true) }

  def done?
    done == true
  end
end
