class CardSet

  include ActiveModel::Model

  validates :cards, presence: true, array_length: { is: 3 }, set: true

  attr_accessor :cards

end
