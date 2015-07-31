module Api::V1
  class GamesController < ApplicationController

    before_action :conflict_error, if: -> { lobby.game.present? },
                                   only: [ :create ]

    def create
      render json: lobby.create_game, serializer: GameSerializer
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

  end
end
