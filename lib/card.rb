class Card

  attr_reader :id

  def initialize(id, attributes)
    @id = id
    @attributes = attributes
  end

  def method_missing(method_name, *args)
    if @attributes.keys.include? method_name
      @attributes[method_name]
    else
      super
    end
  end

end
