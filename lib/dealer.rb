class Dealer

  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def new_deck
    cards.shuffle
  end

  private

  def permutator
    @permutator ||= Permutator.new(attributes)
  end

  def cards
    @cards ||= permutator.each.with_index.map { |perm, i| Card.new(i, perm) }
  end

end
