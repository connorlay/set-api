require 'rails_helper'

RSpec.describe "lobbies", type: :request do

  let(:user) { create :user }

  describe "GET /v1/lobbies/:id" do

    context "with a valid lobby id" do
      let(:lobby) { Lobbies::Creator.new.create_new_lobby(user) }
      let(:path)  { "/v1/lobbies/#{lobby.id}" }
      before { get_with_access_token path, user.access_token }

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
      expect(json['data']['relationships']['users']['data'].first['type']).to eq "users"
      expect(json['data']['relationships']['users']['data'].first['id']).to eq "#{user.id}"
    end
  end
end
