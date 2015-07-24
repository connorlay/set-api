class Deck

  extend Forwardable
  def_delegators :@cards, :pop, :size

  ATTRIBUTES = {
    symbol:  [ :diamond, :sguiggle, :oval ],
    number:  [ :one, :two, :three ],
    color:   [ :red, :green, :purple ],
    shading: [ :solid, :striped, :open ]
  }

  def initialize
    @cards = CardFactory.new(ATTRIBUTES).permutations.shuffle!
  end

end
