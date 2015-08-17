require 'rails_helper'

RSpec.describe GameSerializer, type: :serializer do

  let(:game)          { build_stubbed :game, board: (0...12).to_a, deck: (12...81).to_a }
  let(:serializer)    { GameSerializer.new(game) }
  let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }
  let(:json)          { JSON.parse(serialization.to_json)['data'] }

  let(:cards) { CardsFactory.create_cards }

  it "returns a serialized game" do
    expect(json['type']).to eq 'games'
    expect(json['id']).to   eq game.id.to_s
  end

  it "returns the board as a list of card attributes" do
    expect(json['attributes']['board'].all? do |card|
      card['attributes'].keys.all? do |key|
        cards.find_by_id(card['id']).attributes[key.to_sym] == card['attributes'][key].to_sym
      end
    end).to be true
  end

end
