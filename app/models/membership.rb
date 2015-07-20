class Membership < ActiveRecord::Base

  validates :user, :game, presence: true
  validates :user_id, uniqueness: { scope: :game_id }

  belongs_to :user
  belongs_to :game

end
