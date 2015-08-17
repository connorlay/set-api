class UserSubmitsASet

  attr_reader :lobby, :user, :set

  def initialize(args)
    @lobby = args[:lobby]
    @user  = args[:user]
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
    end
  end

  private

  def game
    @game ||= lobby.game
  end

end
