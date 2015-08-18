class Lobby < ActiveRecord::Base

  has_many :memberships
  has_many :users, through: :memberships
  has_one  :game

  def user?(user)
    users.include? user
  end

  def add_user(user)
    memberships.create(user: user)
  end

  def remove_user(user)
    membership_for(user).destroy
  end

  def increment_score_for(user)
    membership_for(user).increment_score
  end

  def decrement_score_for(user)
    membership_for(user).decrement_score
  end

  def score_for(user)
    membership_for(user).score
  end

  private

  def membership_for(user)
    memberships.find_by(user: user)
  end

end
