# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  user_id      :integer          default(1), not null
#  body         :text
#  subtitle     :string(255)
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  slug         :string(255)      not null
#  excerpt      :text
#  published    :boolean          default(FALSE), not null
#

class Post < ActiveRecord::Base
  # SCOPES
  scope :published, lambda {
    where('published_at < ? AND published = ?', Time.zone.now, true)
      .order('published_at DESC')
  }

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
    if published_at > Time.zone.now
      false
    elsif published == false
      false
    elsif published == true && published_at <= Time.zone.now
      true
    end
  end

  def published_date
    published_at.strftime('%B %-d, %Y')
  end

  def author
    user.name
  end

  def cover(size = nil)
    if cover_asset_present?
      asset = assets.cover.first.asset || assets.first.asset
      size ? asset.url(size) : asset.url
    else
      ActionController::Base.helpers.asset_path 'missing-image.gif'
    end
  end

  private

  def cover_asset_present?
    assets.any? && assets.cover.first.present?
  end
end
