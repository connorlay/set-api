class Sets::Creator

  attr_reader :lobby

  def initialize(args)
    @lobby = args[:lobby]
  end

  def create_new_set(cards:, user:)
    if dealer.valid_set?(cards)
      game.remove_from_board(cards)
      game.deck_to_board(3)
      lobby.increment_score_for(user)
    else
      lobby.decrement_score_for(user)
    end
  end

  private

  def dealer
    @dealer ||= Dealer.new
  end

  def game
    @game ||= lobby.game
  end

end
