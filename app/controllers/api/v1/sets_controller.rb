class Api::V1::SetsController < Api::V1::ApplicationController

  before_action :check_user_membership

  def create
    set = CardSet.new(set_params)
    UserSubmitsASet.new(user: current_user, lobby: lobby).call(set)
    render json: lobby.game, serializer: GameSerializer
  end

  private

  def lobby
    @lobby ||= Lobby.find(params[:lobby_id])
  end

  def set_params
     { cards: params[:cards].map { |id| cards.find_by_id(id.to_i) } }
  end

  def cards
    @cards ||= CardsFactory.create_cards
  end

end
