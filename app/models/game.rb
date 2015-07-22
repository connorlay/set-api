class Game < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  def <<(user)
    memberships.create user: user
  end

end
