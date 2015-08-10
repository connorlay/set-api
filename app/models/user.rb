class User < ActiveRecord::Base

  validates :uid, :name, :oauth_token, :oauth_expires_at, presence: true
  validates :uid, :access_token, uniqueness: true

  after_create :update_access_token!

  has_many :memberships
  has_many :lobbies, through: :memberships

  def score_for(lobby)
    memberships.find_by(lobby: lobby).try(:score)
  end

  class << self

    def authenticate(access_token)
      find_by(access_token: access_token)
    end

    def from_omniauth(auth)
      find_or_initialize_by(uid: auth.uid).tap do |user|
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

  def update_access_token!
    self.access_token = AccessTokens::new_access_token(self)
    self.save!
  end


end
