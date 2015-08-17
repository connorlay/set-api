require 'rails_helper'

RSpec.describe "Authorizations", type: :request do

  describe "GET /v1/users/:id" do
    let(:user) { create :user }
    let(:path) { "/v1/users/#{user.id}" }

    context "with a valid access token" do
      before { get_with_access_token path, user.access_token }

      it_behaves_like "a successfull response"
      it_behaves_like "a response with user data"
    end

    context "with an invalid access token" do
      before { get_with_access_token path, 'bogus_token' }

      it_behaves_like "an authorization error"
    end

    context "without an access token" do
      before { get_with_access_token path, nil }

      it_behaves_like "an authorization error"
    end
  end
end
