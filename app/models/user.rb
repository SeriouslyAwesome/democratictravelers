class User < ActiveRecord::Base
  # SCOPES
  scope :registered, -> { where(guest: false).order('created_at DESC') }
  scope :guests, -> { where(guest: true) }
  scope :inactive, -> { where('updated_at < ?', 14.days.ago) }

  # ASSOCIATIONS
  has_many :experiences, dependent: :destroy
  has_many :locations, through: :experiences

  # VALIDATIONS
  validates :name, presence: true
  validates :uuid, uniqueness: true
  validates :username, uniqueness: true,
                       format: { with: /\A^[a-z0-9\-_]+$\z/i, multiline: true }

  with_options unless: :from_social? do |u|
    u.validates :password, presence: true, length: { in: 4..100 }
    u.validates :password_confirmation, presence: true
    u.validates :email, presence: true, uniqueness: true
  end

  # CALLBACKS
  before_validation :generate_uuid
  before_save :ensure_auth_token
  after_create { add_role :user }
  after_create :subscribe, if: proc { |u| u.email && u.mailing_list? }

  # DELEGATIONS

  # MACROS
  rolify
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :omniauthable, :marketable
  has_reputation :votes, source: { reputation: :votes, of: :experiences },
                         aggregated_by: :sum

  # CALLBACK METHODS
  def generate_uuid
    self.uuid = SecureRandom.hex(8) unless uuid.present?
    self.username = uuid unless username.present?
  end

  def ensure_auth_token
    self.authentication_token = generate_auth_token unless authentication_token
  end

  def subscribe
    Gibbon::API.lists.subscribe id: '32d72a73df', email: { email: email }
  end

  # CLASS METHODS
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.username = auth.info.nickname
      user.name = auth.info.name
      user.location = auth.info.location
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |u|
        u.attributes = params
        u.valid?
      end
    else
      super
    end
  end

  # INSTANCE METHODS
  def admin?
    has_role? :admin
  end

  def from_social?
    provider.present?
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def first_name
    name.split.first
  end

  def last_name
    name.split.last
  end

  def short_name
    n = name.split
    first = n.first
    last = n.size > 1 ? n.last[0, 1] + '.' : ''
    [first, last].reject(&:empty?).join(' ')
  end

  def voted_for?(experience)
    evaluations.where(
      target_type: experience.class,
      target_id: experience.id).present?
  end

  private

  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
