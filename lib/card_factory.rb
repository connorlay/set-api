class CardFactory

  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def permutations
    permutations = (0...@attributes.values.first.size).to_a.repeated_permutation(@attributes.keys.size)
    permutations.each_with_index.map { |perm, i | Card.new i, @attributes.keys.zip(
                                                              @attributes.values.each_with_index
                                                              .map{ |attr, i| attr[perm[i]] }).to_h }
  end

end
