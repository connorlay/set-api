class SetFinder

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def set?
    cards.combination(3).any? { |set| CardSet.new(cards: set).valid? }
  end

end
