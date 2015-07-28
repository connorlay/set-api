class Permutator

  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def each
    return enum_for(:each) unless block_given?
    permutations.each do |perm|
      yield perm
    end
  end

  private

  def key_count
    attributes.keys.count
  end

  def value_count
    attributes.values.first.count
  end

  def permutations
    permutations = (0...value_count).to_a.repeated_permutation(key_count)
    permutations.map do |perm|
      perm.each_with_index
      .map { |value, key| [ attributes.keys[key], attributes[attributes.keys[key]][value] ] }
      .to_h
    end
  end

end
