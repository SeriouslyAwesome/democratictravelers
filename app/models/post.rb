class Post < ActiveRecord::Base
  # SCOPES
  scope :published,
        -> { where('published_at < ? AND published = ?', Time.now, true)
              .order('published_at DESC') }

  # ASSOCIATIONS
  belongs_to :user
  has_many :assets, as: :assetable
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_and_belongs_to_many :experiences

  # VALIDATIONS
  validates :title, presence: true, length: { within: 2..200 }
  validates :slug, presence: true
  validates :user_id, presence: true

  # MACROS
  accepts_nested_attributes_for :assets, :categories
  extend FriendlyId
  friendly_id :title, use: :slugged

  # CLASS METHODS
  def next
    Post.where('id > ?', id).order('id ASC').published.first
  end

  def prev
    Post.where('id < ?', id).order('id DESC').published.first
  end

  # INSTANCE METHODS
  def published?
    if published_at > Time.now
      return false
    elsif published == true && published_at <= Time.now
      return true
    end
  end

  def published_date
    published_at.strftime('%B %-d, %Y')
  end

  def author
    user.name
  end

  def cover(size = nil)
    if assets.any?
      asset = assets.cover.first.asset || assets.first.asset
      size ? asset.url(size) : asset.url
    end
  end
end
