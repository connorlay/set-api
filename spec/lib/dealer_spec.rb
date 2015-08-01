require 'rails_helper'

RSpec.describe Dealer do

  let(:dealer) { Dealer.new }

  describe "#new_deck" do
    let(:deck) { dealer.new_deck }

    it "returns a new deck of cards permuted over its attributes" do
      expect(deck.length).to eq 81
    end
  end

  describe "#get_card" do
    let(:card) { Card.new(0, {symbol:  :diamond,
                              number:  :one,
                              color:   :red,
                              shading: :solid}) }

    it "returns the correct card" do
      expect(dealer.get_card(0)).to eq card
    end
  end

  describe "#get_cards" do
    let(:card1) { Card.new(0, {symbol:  :diamond,
                               number:  :one,
                               color:   :red,
                               shading: :solid}) }
    let(:card2) { Card.new(1, {symbol:  :diamond,
                               number:  :one,
                               color:   :red,
                               shading: :striped}) }
    let(:card3) { Card.new(2, {symbol:  :diamond,
                               number:  :one,
                               color:   :red,
                               shading: :open}) }

    it "returns the correct cards" do
      expect(dealer.get_cards([0,1,2])).to eq [ card1, card2, card3 ]
    end
  end

  describe "#valid_set?" do
    let(:valid_set)   { [ 0, 1, 2 ] }
    let(:invalid_set) { [ 0, 1, 5 ] }

    it "returns true with a valid set" do
      expect(dealer.valid_set?(valid_set)).to be true
    end
    it "returns false with an invalid set" do
      expect(dealer.valid_set?(invalid_set)).to be false
    end
  end
end
