class Lobby < ActiveRecord::Base

  has_many :memberships
  has_many :users, through: :memberships
  has_one  :game

  def has_user?(user)
    users.include? user
  end

end
