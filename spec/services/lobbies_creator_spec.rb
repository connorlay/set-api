require 'rails_helper'

RSpec.describe Lobbies::Creator do

  let(:creator) { Lobbies::Creator.new }

  describe "#create_with_user" do
    let(:user)  { Users::Creator.new.create_new_user(attributes_for :user) }
    let(:lobby) { creator.create_with_user(user) }

    it "returns a new lobby" do
      expect(lobby).to be_an_instance_of Lobby
    end
    it "adds the user as a member" do
      expect(lobby.users.size).to eq 1
      expect(lobby.users).to include user
    end
  end

end
