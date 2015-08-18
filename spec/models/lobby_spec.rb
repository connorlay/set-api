require 'rails_helper'

RSpec.describe Lobby, type: :model do

  subject { create :lobby }

  it { is_expected.to have_many :users }
  it { is_expected.to have_one  :game }

end
