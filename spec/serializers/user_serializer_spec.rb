require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do

  let(:user)          { Users::Creator.new.create_new_user(attributes_for :user) }
  let(:serializer)    { UserSerializer.new(user) }
  let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }
  let(:json)          { JSON.parse(serialization.to_json)['data'] }

  it "returns a serialized user" do
    expect(json['type']).to                    eq 'users'
    expect(json['id']).to                      eq user.id.to_s
    expect(json['attributes']['name']).to      eq user.name
    expect(json['attributes']['image_url']).to eq user.image_url
  end

  it "returns the lobbies" do
    expect(json['relationships'].keys).to include 'lobbies'
  end

end
