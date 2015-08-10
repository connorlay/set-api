require 'rails_helper'

RSpec.describe Sets::Creator do

  let(:user)    { Users::Creator.new.create_new_user(attributes_for :user) }
  let(:lobby)   { create :lobby }
  let(:game)    { Games::Creator.new(lobby).create_new_game }
  let(:creator) { Sets::Creator.new(game) }

  before do
    Lobbies::UserManager.new(lobby).add_user(user)
    game.update_attributes board: (0...12).to_a, deck: (12...81).to_a
  end

  describe "#create_new_set" do

    context "with a valid set" do
      before { creator.create_new_set cards: [ 0, 1, 2 ], user: user }

      it "increments the user's score" do
        expect(user.score_for(lobby)).to eq 1
      end
      it "updates the board" do
        expect(game.board).to eq (3...15).to_a
      end
    end

    context "with an invalid set" do
      before { creator.create_new_set cards: [ 0, 1, 5 ], user: user }

      it "decrements the user's score" do
        expect(user.score_for(lobby)).to eq -1
      end
      it "does not update the board" do
        expect(game.board).to eq (0...12).to_a
      end
    end
  end
end
