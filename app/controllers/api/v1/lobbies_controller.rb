class Api::V1::LobbiesController < Api::V1::ApplicationController

  before_action :check_user_membership, only: [ :show ]

  def create
    new_lobby = Lobbies::Creator.new.create_with_user(current_user)
    render json: new_lobby, serializer: LobbySerializer
  end

  def show
    render json: lobby, serializer: LobbySerializer
  end

  private

  def lobby
    @lobby ||= Lobby.find(params[:id])
  end

end
