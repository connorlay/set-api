class User < ActiveRecord::Base

  validates :uid, :name, :oauth_token, :oauth_expires_at, presence: true
  validates :uid, :access_token, uniqueness: true

  has_many :memberships
  has_many :lobbies, through: :memberships

  after_create :setup!

  class << self

    def authenticate(access_token)
      find_by(access_token: access_token)
    end

    def from_omniauth(auth)
      User.find_or_initialize_by(uid: auth.uid).tap do |user|
        user.uid              = auth.uid
        user.name             = auth.info.name
        user.image_url        = auth.info.image
        user.oauth_token      = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
    end

  end

  private

  def setup!
    update_attributes access_token: AccessTokens.new_access_token(self)
  end

end
