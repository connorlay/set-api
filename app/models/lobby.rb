class Lobby < ActiveRecord::Base

  has_many :memberships
  has_many :users, through: :memberships

  def add_user(user)
    memberships.create user: user
  end

end
