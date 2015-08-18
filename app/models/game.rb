class Game < ActiveRecord::Base

  validates :lobby, presence: true, uniqueness: true

  belongs_to :lobby

  STATUSES = [ :active, :finished ]

  enum status: STATUSES

  def deck_to_board(n)
    unless deck.empty?
      n.times { board << deck.shift }
      save!
    end
  end

  def remove_from_board(ids)
    ids.each { |id| board.delete(id) }
    save!
  end

  def setup!
    deck.shuffle!
    deck_to_board(12)
    save!
  end

end
