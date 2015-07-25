class CardTable

  extend Forwardable
  def_delegators :@cards, :size, :[]

  ATTRIBUTES = {
    symbol:  [ :diamond, :sguiggle, :oval ],
    number:  [ :one, :two, :three ],
    color:   [ :red, :green, :purple ],
    shading: [ :solid, :striped, :open ]
  }

  def initialize
    @cards = CardFactory.new(ATTRIBUTES).permutations
  end

  def ids
    (0...size).to_a
  end

  def cards(ids)
    ids.try(:map) { |id| @cards[id] }
  end

end
