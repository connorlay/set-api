require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:user) { create :user }

  describe "GET /v1/users/:id" do
    context "with a valid user id" do
      let(:path) { "/v1/users/#{user.id}" }
      before { get_with_access_token path, user.access_token }

      it_behaves_like "a successfull response"
      it_behaves_like "a response with user data"
    end

    context "with an invalid user id" do
      let(:path) { "/v1/users/bogus_id" }
      before { get_with_access_token path, user.access_token }

      it_behaves_like "an existance error"
    end
  end
end
