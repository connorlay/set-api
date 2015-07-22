require 'rails_helper'

RSpec.describe "Authorizations", type: :request do

  describe "GET /users/:id" do
    let(:user) { create :user }
    let(:path) { "/users/#{user.id}" }

    context "with a valid access token" do
      before { get_with_access_token path, user.access_token }

      it "responds with user data" do
        expect(response).to have_http_status 200
        expect(json['data']['attributes']).to eq ({"name"=>user.name, "image_url"=>user.image_url})
      end
    end

    context "with an invalid access token" do
      before { get_with_access_token path, 'bogus_token' }

      it "responds with an error" do
        expect(response).to have_http_status 401
        expect(json).to eq ({'error' => I18n.t('errors.unauthorized')})
      end
    end

    context "without an access token" do
      before { get_with_access_token path, nil }

      it "responds with an error" do
        expect(response).to have_http_status 401
        expect(json).to eq ({'error' => I18n.t('errors.unauthorized')})
      end
    end
  end
end
