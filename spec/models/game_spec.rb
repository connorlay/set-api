require 'rails_helper'

RSpec.describe Game, type: :model do

  subject { create :game }

  context "validations" do

    it { is_expected.to belong_to :lobby }

    it "starts with 12 cards on the board" do
      expect(subject.board.count).to eq 12
      expect(subject.deck.count).to eq 69
    end
  end

end
