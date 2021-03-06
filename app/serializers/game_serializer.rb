class GameSerializer < ActiveModel::Serializer
  attributes :id, :board, :status

  def board
    object.board.map do |id|
      card = cards.find_by_id(id)
      { id: card.id, attributes: card.attributes }
    end
  end

  private

  def cards
    @cards ||= CardsTableFactory.create_cards_table
  end

end
