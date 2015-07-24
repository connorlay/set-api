class Card

  def initialize(attributes)
    @attributes = attributes
  end

  def method_missing(method_name, *args)
    if @attributes.keys.include? method_name
      @attributes[method_name]
    else
      super
    end
  end

  def set?(*cards)
    cards << self
    @attributes.keys.all? do |attribute|
      values = cards.map { |card| card.send(attribute) }
      return false unless values.uniq.size == 1 || values.uniq.size == values.size
    end
    return true
  end

end
