require 'rails_helper'

RSpec.describe Lobbies::Creator do

  let(:creator) { Lobbies::Creator.new }

  describe "#create_new_lobby" do
    let(:user)  { create :user }
    let(:lobby) { creator.create_new_lobby(user) }

    it "returns a new lobby" do
      expect(lobby).to be_an_instance_of Lobby
    end
    it "adds the user as a member" do
      expect(lobby.users.size).to eq 1
      expect(lobby.users).to include user
    end
  end

end
