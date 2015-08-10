require 'rails_helper'

RSpec.describe Games::Creator do

  let(:lobby)   { create :lobby }
  let(:creator) { Games::Creator.new(lobby) }

  describe "#create_new_game" do
    let(:game) { creator.create_new_game }

    it "returns a new game" do
      expect(game).to be_an_instance_of Game
    end
    it "adds 12 cards to the board" do
      expect(game.reload.board.size).to eq 12
      expect(game.reload.deck.size).to  eq 69
    end
  end

end
