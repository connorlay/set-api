require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:user) { create :user }

  describe "GET /users/:id" do
    context "with a valid user id" do
      let(:path) { "/users/#{user.id}" }
      before { get_with_access_token path, user.access_token }

      it "responds with user data" do
        expect(response).to have_http_status 200
        expect(json['data']['type']).to eq "users"
        expect(json['data']['attributes']['name']).to eq user.name
        expect(json['data']['attributes']['image_url']).to eq user.image_url
      end
    end

    context "with an invalid user id" do
      let(:path) { "/users/bogus_id" }
      before { get_with_access_token path, user.access_token }

      it "responds with an error" do
        expect(response).to have_http_status 404
        expect(json['error']).to eq I18n.t('users.show.failure')
      end
    end
  end
end
