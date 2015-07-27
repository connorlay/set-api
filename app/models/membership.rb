class Membership < ActiveRecord::Base

  validates :user, :lobby, presence: true
  validates :user_id, uniqueness: { scope: :lobby_id }
  validates :score, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0 }

  belongs_to :user
  belongs_to :lobby

end
