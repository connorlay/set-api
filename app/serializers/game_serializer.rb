class GameSerializer < ActiveModel::Serializer
  attributes :id, :deck, :board
  
end
