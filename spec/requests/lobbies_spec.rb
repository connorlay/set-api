require 'rails_helper'

RSpec.describe "lobbies", type: :request do

  let(:user) { create :user }

  describe "GET /v1/lobbies/:id" do

    context "with a valid lobby id" do
      let(:lobby) { create :lobby }
      let(:path)  { "/v1/lobbies/#{lobby.id}" }
      before do
        lobby.add_user(user)
        get_with_access_token path, user.access_token
      end

      it_behaves_like "a successfull response"
      it_behaves_like "a response with lobby data"
    end

    context "with an invalid lobby id" do
      let(:path) { "/v1/lobbies/bogus_id" }
      before { get_with_access_token path, user.access_token }

      it_behaves_like "an existance error"
    end
  end

  describe "POST /v1/lobbies" do
    let(:path) { "/v1/lobbies" }
    before { post_with_access_token path, user.access_token }

    it_behaves_like "a successfull response"
    it_behaves_like "a response with lobby data"

    it "has the user as a player" do
      expect(json['data']['relationships']['users']['data'].first['id']).to    eq user.id
      expect(json['data']['relationships']['users']['data'].first['score']).to eq Lobby.first.score_for(user)
    end
  end
end
