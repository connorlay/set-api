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

    it { is_expected.to have_many :lobbies }
  end

end
