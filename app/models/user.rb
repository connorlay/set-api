class User < ActiveRecord::Base

  validates :uid, :name, :oauth_token, :oauth_expires_at, presence: true
  validates :uid, :access_token, uniqueness: true

  has_many :memberships
  has_many :lobbies, through: :memberships

  def score_for(lobby)
    memberships.find_by(lobby: lobby).try(:score)
  end

  class << self

    def authenticate(access_token)
      find_by(access_token: access_token)
    end

  end

end
