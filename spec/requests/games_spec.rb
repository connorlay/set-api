require 'rails_helper'

RSpec.describe "Games", type: :request do

  let(:user)  { create :user }
  let(:lobby) { create :lobby }

  describe "GET /v1/lobbies/:id/games/:id" do

    context "with a valid lobby and game id" do
      let(:game)  { create :game, lobby: lobby }
      let(:path)  { "/v1/lobbies/#{lobby.id}/games/#{game.id}" }
      before { get_with_access_token path, user.access_token }

      it "responds with game data" do
        expect(response).to have_http_status 200
        expect(json['data']['type']).to eq "games"
        expect(json['data']['attributes']).to have_key("board")
        expect(json['data']['attributes']).to have_key("deck")
      end
    end

    context "with an invalid game id" do
      let(:path) { "/v1/lobbies/#{lobby.id}/games/bogus_id" }
      before { get_with_access_token path, user.access_token }

      it "responds with an error" do
        expect(response).to have_http_status 404
        expect(json['error']).to eq I18n.t('errors.404')
      end
    end
  end

  describe "POST /v1/lobbies/:id/games" do
    let(:path) { "/v1/lobbies/#{lobby.id}/games" }

    context "without an existing game" do
      before { post_with_access_token path, user.access_token }

      it "responds with the new game data" do
        expect(response).to have_http_status 200
        expect(json['data']['type']).to eq "games"
        expect(json['data']['attributes']).to have_key("board")
        expect(json['data']['attributes']).to have_key("deck")
      end
    end

    context "with an existing game" do
      let!(:game) { create :game, lobby: lobby }
      before { post_with_access_token path, user.access_token }

      it "responds with an error" do
        expect(response).to have_http_status 409
        expect(json['error']).to eq I18n.t('errors.409')
      end
    end
  end


end
