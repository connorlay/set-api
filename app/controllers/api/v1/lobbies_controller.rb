module Api::V1
  class LobbiesController < ApplicationController

    def create
      lobby = Lobby.create
      lobby.add_user(current_user)
      render json: lobby, serializer: LobbySerializer
    end

    def show
      render json: lobby, serializer: LobbySerializer
    end

    private

    def lobby
      @lobby ||= Lobby.find(params[:id])
    end

  end
end
