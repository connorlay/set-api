class Lobbies::Creator

  def create_new_lobby(user)
    Lobby.create.tap { |lobby| add_user(lobby, user) }
  end

  private

  def add_user(lobby, user)
    Lobbies::UserManager.new(lobby).add_user(user)
  end

end
