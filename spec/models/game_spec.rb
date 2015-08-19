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

  describe "#deck_to_board" do

    context "with a full deck" do

      it "adds n cards from the deck to the board" do
        expect {
          subject.deck_to_board(3)
        }.to change {
          [subject.deck.size, subject.board.size]
        }.from([81, 0]).to([78, 3])
      end
    end

    context "with an almost empty deck" do
      before { subject.update_attributes deck: [0, 1] }

      it "only moves the remaining cards" do
        expect {
          subject.deck_to_board(3)
        }.to change {
          [subject.deck.size, subject.board.size]
        }.from([2, 0]).to([0, 2])
      end
    end
  end


end
