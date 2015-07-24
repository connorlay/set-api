class CardFactory

  attr_reader :attributes, :attribute_count, :value_count

  def initialize(attributes)
    @attributes = attributes
    @attribute_count = attributes.keys.size
    @value_count = attributes.values.first.size
  end

  def permutations
    permutations = (0...@value_count).to_a.repeated_permutation(@attribute_count)
    permutations.map { |perm| Card.new @attributes.keys.zip(
                                       @attributes.values.each_with_index
                                       .map{ |a, i| a[perm[i]] }).to_h }
  end

end
