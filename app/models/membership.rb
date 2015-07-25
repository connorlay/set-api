class Membership < ActiveRecord::Base

  validates :user, :game, presence: true
  validates :user_id, uniqueness: { scope: :game_id }
  validates :score, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0 }

  belongs_to :user
  belongs_to :game

end
