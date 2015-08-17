class Api::V1::GamesController < Api::V1::ApplicationController

  before_action :check_user_membership, only: [ :show ]
  before_action :check_existing_game,   only: [ :create ]

  def create
    new_game = Game.create lobby: lobby, deck: cards.ids
    new_game.setup!
    render json: new_game, serializer: GameSerializer
  end

  def show
    render json: game, serializer: GameSerializer
  end

  private

  def game
    @game ||= Game.find(params[:id])
  end

  def lobby
    @lobby ||= Lobby.find(params[:lobby_id])
  end

  def cards
    @cards ||= CardsFactory.create_cards
  end

  def check_existing_game
    conflict_error if lobby.game.present?
  end

end
