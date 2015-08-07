class Api::V1::GamesController < Api::V1::ApplicationController

  before_action :conflict_error, if: -> { lobby.game.present? },
                                 only: [ :create ]
  before_action :check_user_membership, only: [ :show ]

  def create
    game = Games::Creator.new.create_new_game(lobby: lobby)
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

  def move_params
    { cards: params[:cards].map(&:to_i), user: current_user }
  end

end
