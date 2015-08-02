class Games::Creator

  def create_new_game(params)
    Game.create(params).tap { |game| setup(game) }
  end

  private

  def setup(game)
    game.deck = dealer.new_deck.map(&:id).shuffle
    12.times { game.board << game.deck.pop }
  end

  def dealer
    @dealer ||= Dealer.new
  end

end
