require 'rails_helper'

RSpec.describe UserSubmitsASet do

  let(:user)          { create :user }
  let(:lobby)         { create :lobby }
  let(:game)          { create :game, lobby: lobby }
  let(:cards_table)   { CardsTableFactory.create_cards_table }

  let(:interaction)   { UserSubmitsASet.new(user: user, lobby: lobby) }

  before do
    lobby.add_user(user)
    game.update_attributes board: (0...12).to_a, deck: (12...81).to_a
  end

  describe "#call" do

    let(:valid_set)   { CardSet.new cards: cards_table.find_by_ids([ 0, 1, 2 ]) }
    let(:invalid_set) { CardSet.new cards: cards_table.find_by_ids([ 0, 1, 5 ]) }

    context "with a valid set" do
      before { interaction.call(valid_set) }

      it "increments the user's score" do
        expect(lobby.score_for(user)).to eq 1
      end
      it "updates the board" do
        expect(game.board).to eq (3...15).to_a
      end
    end

    context "with an invalid set" do
      before { interaction.call(invalid_set) }

      it "decrements the user's score" do
        expect(lobby.score_for(user)).to eq -1
      end
      it "does not update the board" do
        expect(game.board).to eq (0...12).to_a
      end
    end

    context "when the deck is empty" do
      before { game.update_attributes deck: [] }

      context "when there are other sets left" do
        before { interaction.call(valid_set) }

        it "does not add more cards" do
          expect(game.board).to eq (3...12).to_a
        end
        it "does not change the game state" do
          expect(game).to be_active
        end
      end

      context "when there are no other sets left" do
        before do
          game.update_attributes board: [0, 1, 2, 5, 6, 10]
          interaction.call(valid_set)
        end

        it "does not add more cards" do
          expect(game.board).to eq [5, 6, 10]
        end
        it "changes the game state" do
          expect(game).to be_finished
        end
      end

    end
  end
end
