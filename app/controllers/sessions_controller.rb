class SessionsController < ApplicationController

  skip_before_action :authenticate_user_from_token!

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    render json: { access_token: user.access_token }
  end

end
