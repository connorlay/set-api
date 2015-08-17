module CardsTableFactory

  DEFAULT_CONFIG = [
    [ :symbol,  [ :diamond, :sguiggle, :oval   ] ],
    [ :number,  [ :one,     :two,      :three  ] ],
    [ :color,   [ :red,     :green,    :purple ] ],
    [ :shading, [ :solid,   :striped,  :open   ] ]
  ]

  def self.create_cards
    CardsTable.new cards: permutations(DEFAULT_CONFIG).map(&:to_h)
  end

  private

  def self.permutations(config)
    permutations = (0...config[0][1].size).to_a.repeated_permutation(config.size)
    permutations.map do |perm|
      perm.each_with_index.map do |value, attribute|
        [ config[attribute][0], config[attribute][1][value] ]
      end
    end
  end

end
