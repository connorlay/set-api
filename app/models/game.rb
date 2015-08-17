class Game < ActiveRecord::Base

  validates :lobby, presence: true, uniqueness: true

  belongs_to :lobby

  def deck_to_board(n)
    n.times { board << deck.shift }
    save!
  end

  def remove_from_board(ids)
    ids.each { |id| board.delete(id) }
    save!
  end

end
