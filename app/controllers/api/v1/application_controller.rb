class Api::V1::ApplicationController < ActionController::API

  before_action :check_authentication

  rescue_from ActiveRecord::RecordNotFound, with: :existence_error

  private

  def current_user
    @current_user ||= User.authenticate(access_token)
  end

  def authenticated?
    current_user.present?
  end

  def access_token
    request.headers['Authorization']
  end

  def check_authentication
    authorization_error unless authenticated?
  end

  def check_user_membership
    authorization_error unless lobby.user?(current_user)
  end

  def authorization_error
    render json: { error: I18n.t('errors.401') }, status: 401
  end

  def existence_error
    render json: { error: I18n.t('errors.404') }, status: 404
  end

  def conflict_error
    render json: { error: I18n.t('errors.409') }, status: 409
  end

end
