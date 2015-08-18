class LobbySerializer < ActiveModel::Serializer

  attributes :id

  has_many :users
  has_one  :game

  def users
    object.users.map do |user|
      UserSerializer.new(user).attributes.merge(score: object.score_for(user))
    end
  end

end
