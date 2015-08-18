require 'rails_helper'

RSpec.describe "Games", type: :request do

  let(:user)  { create :user }
  let(:lobby) { create :lobby }
  before { create :membership, lobby: lobby, user: user }

  describe "GET /v1/lobbies/:id/games/:id" do

    context "with a valid lobby and game id" do
      let(:game)  { create :game, lobby: lobby, deck: (0...81).to_a }
      let(:path)  { "/v1/lobbies/#{lobby.id}/games/#{game.id}" }
      before do
        game.setup!
        get_with_access_token path, user.access_token
      end

      it_behaves_like "a successfull response"
      it_behaves_like "a response with game data"
    end

    context "with an invalid game id" do
      let(:path) { "/v1/lobbies/#{lobby.id}/games/bogus_id" }
      before { get_with_access_token path, user.access_token }

      it_behaves_like "an existance error"
    end
  end

  describe "POST /v1/lobbies/:id/games" do
    let(:path) { "/v1/lobbies/#{lobby.id}/games" }

    context "without an existing game" do
      before { post_with_access_token path, user.access_token }

      it_behaves_like "a successfull response"
      it_behaves_like "a response with game data"
    end

    context "with an existing game" do
      let!(:game) { create :game, lobby: lobby }
      before { post_with_access_token path, user.access_token }

      it_behaves_like "an unprocessable entity error"
    end
  end


end
