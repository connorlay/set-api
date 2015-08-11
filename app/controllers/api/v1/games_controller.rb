class Api::V1::GamesController < Api::V1::ApplicationController

  before_action :check_user_membership, only: [ :show ]
  before_action :check_existing_game,   only: [ :create ]

  def create
    game = Games::Creator.new(lobby).create_new_game
    render json: game, serializer: GameSerializer
  end

  def show
    render json: game, serializer: GameSerializer
  end

  private

  def game
    @game ||= Game.find(params[:id])
  end

  def check_user_membership
    authentication_error unless lobby.has_user?(current_user)
  end

  def lobby
    @lobby ||= Lobby.find(params[:lobby_id])
  end

  def check_existing_game
    conflict_error if lobby.game.present?
  end

end
