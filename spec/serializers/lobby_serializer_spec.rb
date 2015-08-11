require 'rails_helper'

RSpec.describe LobbySerializer, type: :serializer do

  let(:user)          { Users::Creator.new.create_new_user(attributes_for :user) }
  let(:lobby)         { Lobbies::Creator.new.create_new_lobby(user) }
  let(:serializer)    { LobbySerializer.new(lobby) }
  let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }
  let(:json)          { JSON.parse(serialization.to_json)['data'] }

  it "returns a serialized lobby" do
    expect(json['type']).to eq 'lobbies'
    expect(json['id']).to   eq lobby.id.to_s
  end

  it "returns the users in the lobby" do
    user_data = json['relationships']['users']['data'].first
    expect(user_data['id']).to        eq user.id
    expect(user_data['name']).to      eq user.name
    expect(user_data['image_url']).to eq user.image_url
    expect(user_data['score']).to     eq user.score_for(lobby)
  end

end
