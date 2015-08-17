class Api::V1::MembershipsController < Api::V1::ApplicationController

  def create
    lobby.add_user(current_user)
    render json: lobby, serializer: LobbySerializer
  end

  private

  def lobby
    @lobby = Lobby.find(params[:id])
  end

end
