module Api::V1
  class MembershipsController < ApplicationController

    def create
      lobby = Lobby.find(params[:id])
      lobby.add_user(current_user)
      render json: lobby, serializer: LobbySerializer
    end

  end
end
