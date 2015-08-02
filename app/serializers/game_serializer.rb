class GameSerializer < ActiveModel::Serializer
  attributes :id, :board

  def board
    dealer.get_cards(object.board)
  end

  private

  def dealer
    @dealer ||= Dealer.new
  end

end
