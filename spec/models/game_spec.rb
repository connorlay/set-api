require 'rails_helper'

RSpec.describe Game, type: :model do

  subject { create :game }

  it { is_expected.to belong_to :lobby }

end
