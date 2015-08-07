class Api::V1::MembershipsController < Api::V1::ApplicationController

  def create
    Lobbies::UserManager.new(lobby).add_user(current_user)
    render json: lobby, serializer: LobbySerializer
  end

  private

  def lobby
    @lobby = Lobby.find(params[:id])
  end

end
