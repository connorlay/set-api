class UserSerializer < ActiveModel::Serializer

  attributes :id, :name, :image_url

  has_many :lobbies

end
