class MembershipsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :game_not_found_error

  def create
    game = Game.find(params[:id])
    game << current_user
    render json: game, serializer: GameSerializer
  end

  private

  def game_not_found_error
    render json: { error: I18n.t('games.show.failure') }, status: 404
  end

end