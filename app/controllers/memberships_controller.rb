class MembershipsController < ApplicationController

  def create
    game = Game.find(params[:id])
    game << current_user
    render json: game, serializer: GameSerializer
  end

end
