class LobbySerializer < ActiveModel::Serializer

  attributes :id, :created_at

  has_many :users

  def users
    object.users.map do |user|
      UserSerializer.new(user).attributes.merge(score: user.score_for(object))
    end
  end

end
