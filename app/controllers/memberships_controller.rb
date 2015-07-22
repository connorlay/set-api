class MembershipsController < ApplicationController

  def create
    game = Game.find(params[:id])
    game.add_user(current_user)
    render json: game, serializer: GameSerializer
  end

end
