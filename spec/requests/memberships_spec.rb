require 'rails_helper'

RSpec.describe "Memberships", type: :request do

  let(:user) { create :user }

  describe "POST /v1/memberships" do

    context "with a valid lobby id" do
      let(:lobby) { create :lobby }
      let(:path)  { "/v1/memberships" }
      before do
        lobby.add_user(user)
        post_with_access_token path, user.access_token, id: lobby.id
      end

      it_behaves_like "a successfull response"
      it_behaves_like "a response with lobby data"

      it "has the user as a player" do
        expect(json['data']['relationships']['users']['data'].first['id']).to eq user.id
      end
    end

    context "with an invalid lobby id" do
      let(:path) { "/v1/memberships" }
      before { post_with_access_token path, user.access_token }

      it_behaves_like "an existance error"
    end
  end
end
