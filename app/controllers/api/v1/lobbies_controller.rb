module Api::V1
  class LobbiesController < ApplicationController

    before_action :check_user_membership, only: [ :show ]

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

    def check_user_membership
      authentication_error unless lobby.has_user?(current_user)
    end

  end
end
