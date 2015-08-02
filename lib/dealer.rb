class Dealer

  CARD_ATTRIBUTES = {
    symbol:  [ :diamond, :sguiggle, :oval ],
    number:  [ :one, :two, :three ],
    color:   [ :red, :green, :purple ],
    shading: [ :solid, :striped, :open ]
  }

  def new_deck
    cards
  end

  def get_card(id)
    cards.detect { |card| card.id == id }
  end

  def get_cards(ids)
    ids.map { |id| get_card(id) }
  end

  def valid_set?(ids)
    set = get_cards(ids)
    CARD_ATTRIBUTES.keys.each do |attr|
      values = set.map { |card| card[attr] }
      return false unless same_or_unique?(values)
    end
    return true
  end

  private

  def permutator
    @permutator ||= Permutator.new(CARD_ATTRIBUTES)
  end

  def cards
    @cards ||= permutator.each.with_index.map { |perm, i| Card.new(i, perm) }
  end

  def same_or_unique?(collection)
    collection.uniq.length == collection.length || collection.uniq.length == 1
  end


end
