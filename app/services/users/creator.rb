class Users::Creator

  def create_new_user(params)
    User.create(params).tap { |user| setup(user) }
  end

  def from_omniauth(auth)
    User.find_or_initialize_by(uid: auth.uid).tap do |user|
      user.uid              = auth.uid
      user.name             = auth.info.name
      user.image_url        = auth.info.image
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      setup(user)
    end
  end

  private

  def setup(user)
    user.update_attributes access_token: AccessTokens.new_access_token(user)
  end

end
