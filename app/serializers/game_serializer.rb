class GameSerializer < ActiveModel::Serializer

  attributes :id, :created_at

  has_many :users

end
