class Game < ActiveRecord::Base

  validates :lobby, presence: true, uniqueness: true

  belongs_to :lobby

end
