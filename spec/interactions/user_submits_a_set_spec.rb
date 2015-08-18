require 'rails_helper'

RSpec.describe UserSubmitsASet do

  let(:user)          { create :user }
  let(:lobby)         { create :lobby }
  let(:game)          { create :game, lobby: lobby }
  let(:cards_table)   { CardsTableFactory.create_cards }

  let(:interaction)   { UserSubmitsASet.new(user: user, lobby: lobby) }

  before do
    lobby.add_user(user)
    game.update_attributes board: (0...12).to_a, deck: (12...81).to_a
  end

  describe "#call" do

    context "with a valid set" do
      let(:set) { CardSet.new cards: cards_table.find_by_ids([ 0, 1, 2 ]) }

      before { interaction.call(set) }

      it "increments the user's score" do
        expect(lobby.score_for(user)).to eq 1
      end
      it "updates the board" do
        expect(game.board).to eq (3...15).to_a
      end
    end

    context "with an invalid set" do
      let(:set) { CardSet.new cards: cards_table.find_by_ids([ 0, 1, 5 ]) }

      before { interaction.call(set) }

      it "decrements the user's score" do
        expect(lobby.score_for(user)).to eq -1
      end
      it "does not update the board" do
        expect(game.board).to eq (0...12).to_a
      end
    end
  end
end
