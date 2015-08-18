class Lobby < ActiveRecord::Base

  has_many :memberships
  has_many :users, through: :memberships
  has_one  :game

  def has_user?(user)
    users.include? user
  end

  def add_user(user)
    memberships.create(user: user)
  end

  def increment_score_for(user)
    memberships.find_by(user: user).increment_score
  end

  def decrement_score_for(user)
    memberships.find_by(user: user).decrement_score
  end

  def score_for(user)
    memberships.find_by(user: user).score
  end

end
