require 'rails_helper'

RSpec.describe Game, type: :model do

  context "validations" do

    it { is_expected.to belong_to :lobby }

  end

end
