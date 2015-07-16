class ApplicationController < ActionController::API

  before_action :authenticate_user_from_token!

  def authenticate_user_from_token!
    token = request.headers['Authorization']

    if token
      authenticate_with_auth_token(token)
    else
      authentication_error
    end
  end

  def current_user
    @current_user
  end


  private

  def authenticate_with_auth_token(token)
    user = User.find_by(access_token: token)

    if user
      @current_user ||= user
    else
      authentication_error
    end
  end

  def authentication_error
    render json: { error: I18n.t('errors.unauthorized') }, status: 401
  end

end
