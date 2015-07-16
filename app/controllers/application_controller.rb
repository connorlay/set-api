class ApplicationController < ActionController::API

  before_action :authentication_error, unless: :authenticated?

  private

  def current_user
    @current_user ||= User.authenticate(access_token)
  end
  helper_method :current_user

  def authenticated?
    current_user
  end
  helper_method :authenticated?

  def access_token
    request.headers['Authorization']
  end

  def authentication_error
    render json: { error: I18n.t('errors.unauthorized') }, status: 401
  end

end
