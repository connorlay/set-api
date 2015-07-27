class Membership < ActiveRecord::Base

  validates :user, :lobby, presence: true
  validates :user_id, uniqueness: { scope: :lobby_id }

  belongs_to :user
  belongs_to :lobby

end
