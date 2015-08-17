class CardsTable

  attr_reader :cards, :ids

  def initialize(args)
    @cards = args[:cards]
    @ids   = (0...cards.size).to_a
  end

  def find_by_id(id)
    OpenStruct.new id: id, attributes: cards[id]
  end

  def find_by_ids(ids)
    ids.map { |id| find_by_id(id) }
  end

  def find_by_cards(cards)
    cards.map { |card| find_by_card(card) }
  end

  def find_by_card(card)
    OpenStruct.new id: cards.index_of(card), attributes: card
  end

end
