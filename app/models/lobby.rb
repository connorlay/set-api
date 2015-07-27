class Lobby < ActiveRecord::Base

  has_many :memberships
  has_many :users, through: :memberships
  has_one  :game

  def add_user(user)
    memberships.create user: user
  end

end
