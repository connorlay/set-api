class Sets::Creator

  attr_reader :game

  def initialize(game)
    @game = game
  end

  def create_new_set(cards:, user:)
    if dealer.valid_set?(cards)
      remove_cards_from_board(cards)
      add_cards_to_board
      score_updater.increment_score(user)
    else
      score_updater.decrement_score(user)
    end
  end

  private

  def remove_cards_from_board(cards)
    cards.each { |card| game.board.delete(card) }
    game.save!
  end

  def add_cards_to_board
    3.times { game.board << game.deck.shift }
    game.save!
  end

  def dealer
    @dealer ||= Dealer.new
  end

  def score_updater
    @score_updater ||= Lobbies::ScoreUpdater.new(game.lobby)
  end

end
