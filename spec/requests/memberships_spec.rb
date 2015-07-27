require 'rails_helper'

RSpec.describe "Memberships", type: :request do

  let(:user) { create :user }

  describe "POST /v1/memberships" do

    context "with a valid lobby id" do
      let(:lobby) { create :lobby }
      let(:path) { "/v1/memberships" }
      before { post_with_access_token path, user.access_token, id: lobby.id }

      it "reponds with the lobby data" do
        expect(response).to have_http_status 200
        expect(json['data']['type']).to eq "lobbies"
        expect(json['data']['id']).to eq "#{lobby.id}"
      end
      it "has the user as a player" do
        expect(json['data']['relationships']['users']['data'].first['type']).to eq "users"
        expect(json['data']['relationships']['users']['data'].first['id']).to eq "#{user.id}"
      end
    end

    context "with an invalid lobby id" do
      let(:path) { "/v1/memberships" }
      before { post_with_access_token path, user.access_token }

      it "responds with an error" do
        expect(response).to have_http_status 404
        expect(json['error']).to eq I18n.t('errors.404')
      end
    end
  end
end
