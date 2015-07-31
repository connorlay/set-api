class Game < ActiveRecord::Base

  validates :lobby, presence: true, uniqueness: true

  belongs_to :lobby

  before_create :setup_game

  CARD_ATTRIBUTES = {
    symbol:  [ :diamond, :sguiggle, :oval ],
    number:  [ :one, :two, :three ],
    color:   [ :red, :green, :purple ],
    shading: [ :solid, :striped, :open ]
  }

  private

  def dealer
    @dealer ||= Dealer.new(CARD_ATTRIBUTES)
  end

  def setup_game
    self.deck  = dealer.new_deck.map(&:id)
    self.board = deck.pop(12)
  end

end
