require 'rails_helper'

RSpec.describe "Sets", type: :request do

  let(:user)  { create :user }
  let(:lobby) { create :lobby }
  let(:game)  { create :game, lobby: lobby }

  before { lobby.add_user(user) }

  describe "POST /v1/lobbies/:id/games/:id/sets" do
    let(:path) { "/v1/lobbies/#{lobby.id}/games/#{game.id}/sets" }
    before { game.update_attributes(board: (0...12).to_a, deck: (12...81).to_a) }

    context "with a valid set" do
      before { post_with_access_token path, user.access_token, cards: [0, 1, 2] }

      it_behaves_like "a successfull response"
      it_behaves_like "a response with game data"

      it "has new cards on the board" do
        expect(json['data']['attributes']['board'].map { |card| card['id'] }).to eq (3...15).to_a
      end
    end

    context "with an invalid set" do
      before { post_with_access_token path, user.access_token, cards: [0, 1, 5] }

      it_behaves_like "a successfull response"
      it_behaves_like "a response with game data"

      it "has the same cards on the board" do
        expect(json['data']['attributes']['board'].map { |card| card['id'] }).to eq (0...12).to_a
      end
    end

    context "when the deck is empty" do
      before { game.update_attributes deck: [] }

      context "when there are other sets on the board" do
        before { post_with_access_token path, user.access_token, cards: [0, 1, 2] }

        it_behaves_like "a successfull response"
        it_behaves_like "a response with game data"

        it "does not have new cards on the board" do
          expect(json['data']['attributes']['board'].map { |card| card['id']}).to eq (3...12).to_a
        end
        it "does not change the game status" do
          expect(json['data']['attributes']['status']).to eq 'active'
        end
      end

      context "when there are no other sets on the board" do
        before do
          game.update_attributes board: [0, 1, 2, 5, 6, 10]
          post_with_access_token path, user.access_token, cards: [0, 1, 2]
        end

        it_behaves_like "a successfull response"
        it_behaves_like "a response with game data"

        it "does not have new cards on the board" do
          expect(json['data']['attributes']['board'].map { |card| card['id']}).to eq [5, 6, 10]
        end
        it "changes the game state" do
          expect(json['data']['attributes']['status']).to eq 'finished'
        end
      end

      context "when the user is not a member" do
        before do
          lobby.remove_user(user)
          post_with_access_token path, user.access_token, cards: [0, 1, 2]
        end

        it_behaves_like "an authorization error"
      end

      context "when the game is finished" do
        before do
          game.finished!
          post_with_access_token path, user.access_token, cards: [0, 1, 2]
        end

        it_behaves_like "an unprocessable entity error"
      end
    end

  end
end
