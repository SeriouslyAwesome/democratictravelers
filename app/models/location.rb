class Location < ApplicationRecord
  # SCOPES
  default_scope { order('votes_cache DESC') }
  scope :done, -> { where(done: true) }
  scope :suggested, (lambda do
    includes(:state, :experiences).where('experiences_count > ?', 0)
  end)

  # ASSOCIATIONS
  belongs_to :state, optional: true
  has_many :experiences
  has_many :users, through: :experiences

  # VALIDATIONS
  validates :country_id, inclusion: { in: [228] }
  validates :state_id, presence: true, numericality: { only_integer: true }
  validates :lat, presence: true, numericality: true
  validates :long, presence: true, numericality: true

  # CALLBACKS
  before_validation { self.country_id = 228 }
  before_save { self.experiences_count = experiences.count }
  before_save { self.votes_cache = compute_votes }

  # ALIASES
  alias_attribute :venue, :name

  # MACROS
  geocoded_by :formatted_address, latitude: :lat, longitude: :long
  reverse_geocoded_by :lat, :long

  # CALLBACK METHODS

  # CLASS METHODS
  def self.current
    find_by(current: true)
  end

  # INSTANCE METHODS
  def reputation_for(_name)
    compute_votes
  end

  private

  def compute_votes
    Vote.where(votable_type: 'Experience', votable_id: experiences.select(:id)).sum(:value)
  end
end
