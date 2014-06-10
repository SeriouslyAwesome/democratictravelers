class Experience < ActiveRecord::Base
  # SCOPES
  default_scope { includes(:user, location: :state) }
  scope :full_list, -> { includes(:evaluations, location: :state)
                           .order('experiences.created_at DESC') }
  scope :popular, -> { includes(:posts).order('votes_cache DESC') }
  scope :recent, -> { includes(:posts).order('experience.created_at DESC') }
  scope :closest, -> { order('distance ASC') }
  scope :done, -> { where(done: true) }

  # ASSOCIATIONS
  belongs_to :user
  belongs_to :location, counter_cache: true
  has_one :state, through: :location
  has_and_belongs_to_many :posts

  # VALIDATIONS
  validates :name, presence: true
  validates :location, presence: true
  validates :user, presence: true

  # CALLBACKS
  before_save :set_distance
  before_save :cache_vote_count
  after_create :auto_upvote

  # DELEGATIONS
  delegate :city, to: :location
  delegate :state, to: :location
  delegate :venue, to: :location

  # MACROS
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_reputation :votes, source: :user, aggregated_by: :sum
  accepts_nested_attributes_for :location

  # CALLBACK METHODS
  def set_distance
    self.distance = location.distance_from(Location.current)
  end

  def cache_vote_count
    self.votes_cache = reputation_for(:votes)
  end

  def auto_upvote
    upvote(user)
  end

  # INSTANCE METHODS
  def upvote(user)
    add_or_update_evaluation(:votes, 1, user)
    update_attributes(votes_cache: reputation_for(:votes))
  end

  def downvote(user)
    add_or_update_evaluation(:votes, -1, user)
    update_attributes(votes_cache: reputation_for(:votes))
  end

  def mark_done
    update_attributes done: true
    location.update_attributes done: true
    ExperienceMailer.delay.we_did_this(id) if user.email.present?
  end

  def name_for_checkboxes
    "#{name} (at #{venue} in #{city}, #{state.abbr})"
  end

  def date_to_i
    created_at.to_i
  end

  def voted_up?(user)
    check_vote_status(user, 1)
  end

  def voted_down?(user)
    check_vote_status(user, -1)
  end

  def submitter
    user.present? ? user : NullUser.new
  end

  private

  def check_vote_status(user, value)
    evaluation = evaluations.select { |e| e.source_id == user.id }.first
    evaluation && evaluation.value == value ? true : false
  end
end
