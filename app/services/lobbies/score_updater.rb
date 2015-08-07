class Lobbies::ScoreUpdater

  attr_reader :lobby

  def initialize(lobby)
    @lobby = lobby
  end

  def increment_score(user)
    membership(user).increment!(:score)
  end

  def decrement_score(user)
    membership(user).decrement!(:score)
  end

  private

  def membership(user)
    lobby.memberships.find_by(user: user)
  end

end
