require 'rails_helper'

RSpec.describe Game, type: :model do

  subject { create :game, deck: (0...81).to_a }

  it { is_expected.to belong_to :lobby }

  describe "#setup!" do
    before { subject.setup! }

    it "adds 12 cards from the deck to the board" do
      expect(subject.board.size).to eq 12
      expect(subject.deck.size).to  eq 69
    end
  end

end
