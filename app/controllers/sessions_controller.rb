class SessionsController < ApplicationController

  skip_before_action :authentication_error

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    render json: { access_token: user.access_token }
  end

end
