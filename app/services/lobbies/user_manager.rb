class Lobbies::UserManager

  attr_reader :lobby

  def initialize(lobby)
    @lobby = lobby
  end

  def add_user(user)
    lobby.memberships.create(user: user)
  end

end
