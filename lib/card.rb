class Card

  extend Forwardable

  attr_reader  :id, :attributes
  def_delegator :@attributes, :[]

  def initialize(id, attributes)
    @id = id
    @attributes = attributes
  end

  def ==(other_card)
    (self.id == other_card.id) && (self.attributes == other_card.attributes)
  end

end
