require 'rails_helper'

RSpec.describe Games::Creator  do

  let(:creator) { Games::Creator.new }

  describe "#create_new_game" do
    let(:game) { creator.create_new_game(attributes_for :game) }

    it "returns a new game" do
      expect(game).to be_an_instance_of Game
    end
    it "adds 12 cards to the board" do
      expect(game.board.size).to eq 12
      expect(game.deck.size).to  eq 69
    end
  end

end
