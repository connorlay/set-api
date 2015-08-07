class Api::V1::UsersController < Api::V1::ApplicationController

  def show
    user = User.find(params['id'])
    render json: user, serializer: UserSerializer
  end

end
