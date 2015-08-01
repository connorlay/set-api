class Game < ActiveRecord::Base

  validates :lobby, presence: true, uniqueness: true

  belongs_to :lobby

  before_create :setup_game

  def deck
    dealer.get_cards(read_attribute(:deck))
  end

  def board
    dealer.get_cards(read_attribute(:board))
  end

  private

  def dealer
    @dealer ||= Dealer.new
  end

  def setup_game
    self.deck  = dealer.new_deck.map(&:id)
    self.board = read_attribute(:deck).pop(12)
  end

end
