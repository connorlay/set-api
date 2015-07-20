require 'rails_helper'

RSpec.describe User, type: :model do

  context "validations" do
    subject { create :user }

    it { is_expected.to validate_presence_of :uid }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :oauth_token }
    it { is_expected.to validate_presence_of :oauth_expires_at }

    it { is_expected.to validate_uniqueness_of :uid }
    it { is_expected.to validate_uniqueness_of :access_token }

    it { is_expected.to have_db_index :uid }
    it { is_expected.to have_db_index :access_token }

    it { is_expected.to have_many :games }
  end

  describe "#from_omniauth" do
    let(:user) { build :user }
    let(:auth) { omniauth_hash_for user }

    context "with a new user" do

      it "creates a new user record" do
        expect {
          User.from_omniauth(auth)
        }.to change {
          User.count
        }.by 1
      end
    end

    context "with a returning user" do
      before { user.save! }

      it "does not create a new user record" do
        expect {
          User.from_omniauth(auth)
        }.not_to change {
          User.count
        }
      end

      context "with new fields" do
        before { auth.info.name = "A new name" }

        it "updates the existing record" do
          expect {
            User.from_omniauth(auth)
          }.to change {
            User.find(user.id).name
          }
        end
      end
    end
  end

end
