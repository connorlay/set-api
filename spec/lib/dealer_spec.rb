require 'rails_helper'

RSpec.describe Dealer do

  CARD_ATTRIBUTES = {
    one: [ :a, :b ],
    two: [ :c, :d ]
  }

  let(:dealer) { Dealer.new(CARD_ATTRIBUTES) }

  describe "#new_deck" do
    subject { dealer.new_deck }

    it "returns a new deck of cards permuted over its attributes" do
      expect(subject.size).to eq 4
      expect(subject.any? { |card| card.one == :a && card.two == :c}).to be true
      expect(subject.any? { |card| card.one == :a && card.two == :d}).to be true
      expect(subject.any? { |card| card.one == :b && card.two == :c}).to be true
      expect(subject.any? { |card| card.one == :b && card.two == :d}).to be true
    end
  end

end
