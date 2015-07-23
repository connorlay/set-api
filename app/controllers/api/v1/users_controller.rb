module Api::V1
  class UsersController < ApplicationController

    def show
      user = User.find(params['id'])
      render json: user, serializer: UserSerializer
    end

  end
end