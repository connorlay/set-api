class Game < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  def <<(user)
    Membership.create user: user, game: self
  end

end
