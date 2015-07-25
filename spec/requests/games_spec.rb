require 'rails_helper'

RSpec.describe "Games", type: :request do

  let(:user) { create :user }

  describe "GET /v1/games/:id" do

    context "with a valid game id" do
      let(:game) { create :game }
      let(:path) { "/v1/games/#{game.id}" }
      before { get_with_access_token path, user.access_token }

      it "responds with game data" do
        expect(response).to have_http_status 200
        expect(json['data']['type']).to eq "games"
        expect(json['data']['attributes']).to have_key("created_at")
        expect(json['data']['attributes']['board'].size).to be 12
        expect(json['data']['attributes']['deck'].size).to be 69
      end
    end

    context "with an invalid game id" do
      let(:path) { "/v1/games/bogus_id" }
      before { get_with_access_token path, user.access_token }

      it "responds with an error" do
        expect(response).to have_http_status 404
        expect(json['error']).to eq I18n.t('errors.404')
      end
    end
  end

  describe "POST /api/v1/games" do
    let(:path) { "/v1/games" }
    before { post_with_access_token path, user.access_token }

    it "reponds with the new game data" do
      expect(response).to have_http_status 200
      expect(json['data']['type']).to eq "games"
    end
    it "has the user as a player" do
      expect(json['data']['relationships']['users']['data'].first['type']).to eq "users"
      expect(json['data']['relationships']['users']['data'].first['id']).to eq "#{user.id}"
    end
  end
end
