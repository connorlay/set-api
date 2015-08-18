class CardSet

  include ActiveModel::Model

  validates :cards, presence: true, array_length: 3

  validates_with SetValidator, if: -> { cards.present? }

  attr_accessor :cards

end
