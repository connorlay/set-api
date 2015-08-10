require 'rails_helper'

RSpec.describe "Authentication", type: :request do

  describe "GET /auth/facebook" do
    before  { get "/auth/facebook" }
    subject { response }

    it_behaves_like "a redirection"
    it { is_expected.to redirect_to "/auth/facebook/callback" }
  end

  describe "GET /auth/facebook/callback" do
    before     { OmniAuth.config.mock_auth[:facebook] = omniauth_hash_for(user) }
    let(:user) { build :user }

    context "with a new user" do

      it "creates a new user record and returns an access token" do
        expect {
          get "/auth/facebook/callback"
        }.to change {
          User.count
        }.by 1
        expect(response).to have_http_status 200
        expect(json["access_token"]).to eq User.find_by(uid: user.uid).access_token
      end

    end

    context "with a returning user" do
      before { user.save! }

      it "updates the user record and returns an access token" do
        expect {
          get "/auth/facebook/callback"
        }.not_to change {
          User.count
        }
        expect(response).to have_http_status 200
        expect(json["access_token"]).to eq user.reload.access_token
      end
    end

  end
end
