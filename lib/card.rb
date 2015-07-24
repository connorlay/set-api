class Card

  ATTRIBUTES = {
    symbol:  [ :diamond, :sguiggle, :oval ],
    number:  [ :one, :two, :three ],
    color:   [ :red, :green, :purple ],
    shading: [ :solid, :striped, :open ]
  }

  attr_accessor *ATTRIBUTES.keys

  def initialize(attributes)
    attributes.each { |key, value| send("#{key}=", value) }
  end

  def self.new_deck
    permutations = (0...ATTRIBUTES.values.first.length).to_a.repeated_permutation(ATTRIBUTES.keys.length)
    permutations.map { |perm| Card.new ATTRIBUTES.keys.zip(
                                       ATTRIBUTES.values.each_with_index
                                       .map{ |a, i| a[perm[i]] }).to_h }
  end

end
