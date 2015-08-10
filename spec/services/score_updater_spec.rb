require 'rails_helper'

RSpec.describe Lobbies::ScoreUpdater do

  let(:user)  { Users::Creator.new.create_new_user(attributes_for :user) }
  let(:lobby) { Lobbies::Creator.new.create_new_lobby(user) }
  let(:score_updater) { Lobbies::ScoreUpdater.new(lobby) }

  describe "#increment_score" do

    it "increments the user's score for the given lobby" do
      expect {
        score_updater.increment_score(user)
      }.to change {
        user.memberships.find_by(lobby: lobby).score
      }.by 1
    end
  end

  describe "#decrement_score" do

    it "decrements the user's score for the given lobby" do
      expect {
        score_updater.decrement_score(user)
      }.to change {
        user.memberships.find_by(lobby: lobby).score
      }.by -1
    end
  end

end
