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
    Membership.find_by(lobby: lobby, user: user)
  end

end
