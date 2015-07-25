class GameSerializer < ActiveModel::Serializer

  attributes :id, :created_at, :board, :deck

  has_many :users

end
