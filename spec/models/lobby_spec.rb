require 'rails_helper'

RSpec.describe Lobby, type: :model do

  subject { create :lobby }

  context "validations" do

    it { is_expected.to have_many :users }
    it { is_expected.to have_one  :game }
  end

  describe "#add_user" do
    let(:user) { create :user }

    it "add the user as a member" do
      expect {
        subject.add_user user
      }.to change {
        Membership.count
      }.by 1
      expect(subject.users).to include user
    end
  end

end
