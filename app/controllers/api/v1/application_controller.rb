module Api::V1
  class ApplicationController < ActionController::API

    before_action :authentication_error, unless: :authenticated?

    rescue_from ActiveRecord::RecordNotFound, with: :existence_error

    private

    def current_user
      @current_user ||= User.authenticate(access_token)
    end
    helper_method :current_user

    def authenticated?
      current_user.present?
    end
    helper_method :authenticated?

    def access_token
      request.headers['Authorization']
    end

    def authentication_error
      render json: { error: I18n.t('errors.401') }, status: 401
    end

    def existence_error
      render json: { error: I18n.t('errors.404') }, status: 404
    end

    def conflict_error
      render json: { error: I18n.t('errors.409') }, status: 409
    end

  end
end
