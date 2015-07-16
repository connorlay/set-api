module OmniAuthHelper

  def login_with_omniauth(user)
    OmniAuth.config.mock_auth['facebook'] = omniauth_hash_for(user)
    visit "/auth/facebook"
  end

  def omniauth_hash_for(user)
    OmniAuth::AuthHash.new({ uid:         user.uid,
                             info:        { name:       user.name,
                                            image:      user.image_url },
                             credentials: { token:      user.oauth_token,
                                            expires_at: user.oauth_expires_at } })
  end

end