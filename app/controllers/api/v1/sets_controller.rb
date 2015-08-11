class Api::V1::SetsController < Api::V1::ApplicationController

  before_action :check_user_membership

  def create
    Sets::Creator.new(game).create_new_set(set_params)
    render json: game, serializer: GameSerializer
  end

  private

  def game
    @game ||= Game.find(params[:game_id])
  end

  def lobby
    @lobby ||= game.lobby
  end

  def set_params
    { cards: params[:cards].map(&:to_i), user: current_user }
  end

end
