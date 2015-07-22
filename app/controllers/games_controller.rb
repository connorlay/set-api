class GamesController < ApplicationController

  def create
    game = Game.create
    game << current_user
    render json: game, serializer: GameSerializer
  end

  def show
    game = Game.find(params[:id])
    render json: game, serializer: GameSerializer
  end

end
