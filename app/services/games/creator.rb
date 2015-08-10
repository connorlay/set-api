class Games::Creator

  attr_reader :lobby

  def initialize(lobby)
    @lobby = lobby
  end

  def create_new_game
    Game.create(lobby: lobby).tap { |game| setup(game) }
  end

  private

  def setup(game)
    game.deck = dealer.new_deck.map(&:id).shuffle
    12.times { game.board << game.deck.pop }
    game.save!
  end

  def dealer
    @dealer ||= Dealer.new
  end

end
