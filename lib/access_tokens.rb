module AccessTokens

  class << self

    def new_token
      SecureRandom.urlsafe_base64
    end

    def new_access_token(user)
      "#{user.id}:#{new_token}"
    end

  end

end