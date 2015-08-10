class Api::V1::SessionsController < Api::V1::ApplicationController

  skip_before_action :check_authentication

  def create
    user = Users::Creator.new.from_omniauth(request.env["omniauth.auth"])
    render json: { access_token: user.access_token }
  end

end
