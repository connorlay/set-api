class Game < ActiveRecord::Base

  validates :deck, :board, presence: true

  has_many :memberships
  has_many :users, through: :memberships

  after_initialize :setup_game

  def add_user(user)
    memberships.create user: user
  end

  def board
    @card_table.cards read_attribute(:board)
  end

  def deck
    @card_table.cards read_attribute(:deck)
  end

  private

  def card_table
    @card_table ||= CardTable.new
  end

  def setup_game
    write_attribute :deck, card_table.ids.shuffle
    12.times { read_attribute(:board) << read_attribute(:deck).pop }
    save!
  end

end
