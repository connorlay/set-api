class CardSet

  include ActiveModel::Model

  validates :cards, presence: true

  validates_with SetValidator

  attr_accessor :cards

end
