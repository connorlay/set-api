require 'rails_helper'

RSpec.describe "Games", type: :request do

  let(:user) { create :user }

  describe "GET /games/:id" do

    context "with a valid game id" do
      let(:game) { create :game }
      let(:path) { "/games/#{game.id}" }
      before { get_with_access_token path, user.access_token }

      it "responds with game data" do
        expect(response).to have_http_status 200
        expect(json['data']['type']).to eq "games"
        expect(json['data']['attributes']).to have_key("created_at")
      end
    end

    context "with an invalid game id" do
      let(:path) { "/games/bogus_id" }
      before { get_with_access_token path, user.access_token }

      it "responds with an error" do
        expect(response).to have_http_status 404
        expect(json['error']).to eq I18n.t('games.show.failure')
      end
    end
  end

  describe "POST /games" do
    let(:path) { "/games" }
    before { post_with_access_token path, user.access_token }

    it "reponds with the new game data" do
      expect(response).to have_http_status 200
      expect(json['data']['type']).to eq "games"
    end
    it "has the user as a player" do
      expect(json['data']['relationships']['users']['data'].first['type']).to eq "users"
      expect(json['data']['relationships']['users']['data'].first['id']).to eq user.id.to_s
    end
  end
end
