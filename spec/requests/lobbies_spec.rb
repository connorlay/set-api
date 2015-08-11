require 'rails_helper'

RSpec.describe "lobbies", type: :request do

  let(:user) { create :user }

  describe "GET /v1/lobbies/:id" do

    context "with a valid lobby id" do
      let(:lobby) { create :lobby }
      let(:path) { "/v1/lobbies/#{lobby.id}" }
      before do
        create :membership, user: user, lobby: lobby
        get_with_access_token path, user.access_token
      end

      it "responds with lobby data" do
        expect(response).to have_http_status 200
        expect(json['data']['type']).to eq "lobbies"
        expect(json['data']['attributes']).to have_key("created_at")
      end
    end

    context "with an invalid lobby id" do
      let(:path) { "/v1/lobbies/bogus_id" }
      before { get_with_access_token path, user.access_token }

      it "responds with an error" do
        expect(response).to have_http_status 404
        expect(json['error']).to eq I18n.t('errors.404')
      end
    end
  end

  describe "POST /v1/lobbies" do
    let(:path) { "/v1/lobbies" }
    before { post_with_access_token path, user.access_token }

    it "reponds with the new lobby data" do
      expect(response).to have_http_status 200
      expect(json['data']['type']).to eq "lobbies"
    end
    it "has the user as a player" do
      expect(json['data']['relationships']['users']['data'].first['type']).to eq "users"
      expect(json['data']['relationships']['users']['data'].first['id']).to eq "#{user.id}"
    end
  end
end
