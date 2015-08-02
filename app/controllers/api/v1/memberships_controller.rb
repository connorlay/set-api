class Api::V1::MembershipsController < Api::V1::ApplicationController

  def create
    lobby = Lobby.find(params[:id])
    Lobbies::UserManager.new(lobby).add_user(current_user)
    render json: lobby, serializer: LobbySerializer
  end

end
