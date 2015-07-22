class UsersController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found_error

  def show
    user = User.find(params['id'])
    render json: user, serializer: UserSerializer
  end

  private

  def user_not_found_error
    render json: { error: I18n.t('users.show.failure') }, status: 404
  end

end
