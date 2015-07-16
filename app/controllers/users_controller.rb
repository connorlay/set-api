class UsersController < ApplicationController

  def show
    user = User.find(params['id'])
    render json: { name: user.name, image: user.image_url }
  end

end

