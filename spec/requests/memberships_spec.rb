require 'rails_helper'

RSpec.describe "Memberships", type: :request do

  let(:user) { create :user }

  describe "POST /memberships" do

    context "with a valid game id" do
      let(:game) { create :game }
      let(:path) { "/memberships" }
      before { post_with_access_token path, user.access_token, id: game.id }

      it "reponds with the game data" do
        expect(response).to have_http_status 200
        expect(json['data']['type']).to eq "games"
        expect(json['data']['id']).to eq "#{game.id}"
      end
      it "has the user as a player" do
        expect(json['data']['relationships']['users']['data'].first['type']).to eq "users"
        expect(json['data']['relationships']['users']['data'].first['id']).to eq "#{user.id}"
      end
    end

    context "with an invalid game id" do
      let(:path) { "/memberships" }
      before { post_with_access_token path, user.access_token }

      it "responds with an error" do
        expect(response).to have_http_status 404
        expect(json['error']).to eq I18n.t('games.show.failure')
      end
    end
  end
end
