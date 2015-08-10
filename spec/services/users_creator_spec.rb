require 'rails_helper'

RSpec.describe Users::Creator do

  let(:creator) { Users::Creator.new }
  let(:user)    { build :user }
  let(:auth)    { omniauth_hash_for user }

  describe "#from_omniauth" do

    context "with a new user" do

      it "creates a new user record" do
        expect {
          creator.from_omniauth(auth)
        }.to change {
          User.count
        }.by 1
      end
    end

    context "with a returning user" do
      before { user.save! }

      it "does not create a new user record" do
        expect {
          creator.from_omniauth(auth)
        }.not_to change {
          User.count
        }
      end

      context "with new fields" do
        before { auth.info.name = "A new name" }

        it "updates the existing record" do
          expect {
            creator.from_omniauth(auth)
          }.to change {
            User.find(user.id).name
          }
        end
      end
    end
  end

end
