module Api::V1
  class ApplicationController < ActionController::API

    before_action :authentication_error, unless: :authenticated?

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error

    private

    def current_user
      @current_user ||= User.authenticate(access_token)
    end
    helper_method :current_user

    def authenticated?
      !current_user.nil?
    end
    helper_method :authenticated?

    def access_token
      request.headers['Authorization']
    end

    def authentication_error
      render json: { error: I18n.t('errors.401') }, status: 401
    end

    def record_not_found_error
      render json: { error: I18n.t('errors.404') }, status: 404
    end

  end
end
