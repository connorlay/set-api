require 'rails_helper'

RSpec.describe GameSerializer, type: :serializer do

  let(:game)          { build_stubbed :game, board: (0...12).to_a, deck: (12...81).to_a }
  let(:serializer)    { GameSerializer.new(game) }
  let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }
  let(:json)          { JSON.parse(serialization.to_json)['data'] }

  let(:dealer) { Dealer.new(Game::CARD_ATTRIBUTES) }

  it "returns a serialized game" do
    expect(json['type']).to eq 'games'
    expect(json['id']).to   eq game.id.to_s
  end

  it "returns the deck as a list of card attributes" do
    expect(json['attributes']['deck'].all? do |card|
      card['attributes'].keys.all? do |key|
        dealer.get_card(card['id']).send(key) == card['attributes'][key].to_sym
      end
    end).to be true
  end

  it "returns the board as a list of card attributes" do
    expect(json['attributes']['board'].all? do |card|
      card['attributes'].keys.all? do |key|
        dealer.get_card(card['id']).send(key) == card['attributes'][key].to_sym
      end
    end).to be true
  end

end
