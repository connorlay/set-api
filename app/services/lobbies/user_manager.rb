class Lobbies::UserManager

  attr_reader :lobby

  def initialize(lobby)
    @lobby = lobby
  end

  def add_user(user)
    Membership.create lobby: lobby, user: user
  end

end
