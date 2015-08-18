class UserSubmitsASet

  attr_reader :lobby, :user

  def initialize(lobby:, user:)
    @lobby = lobby
    @user  = user
  end

  def call(set)
    ActiveRecord::Base.transaction do
      if set.valid?
        game.remove_from_board(set.cards.map(&:id))
        game.deck_to_board(3)
        lobby.increment_score_for(user)
      else
        lobby.decrement_score_for(user)
      end
      check_game_state
    end
  end

  private

  def game
    @game ||= lobby.game
  end

  def set_finder
    @set_finder ||= SetFinder.new(cards_table.find_by_ids(game.board))
  end

  def cards_table
    @cards_table ||= CardsTableFactory.create_cards_table
  end
  
  def check_game_state
    game.deck_to_board(3) unless set_finder.set?
    game.finished! if game.deck.empty? && !set_finder.set?
  end

end
