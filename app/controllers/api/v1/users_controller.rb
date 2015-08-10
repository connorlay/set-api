class Api::V1::UsersController < Api::V1::ApplicationController

  def show
    render json: user, serializer: UserSerializer
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

end
