require 'rails_helper'

RSpec.describe Game, type: :model do

  subject { create :game }

  context "validations" do

    it { is_expected.to have_many :users }
    it { is_expected.to validate_presence_of :deck }
    it { is_expected.to validate_presence_of :board }

    it "starts with 12 cards on the board" do
      expect(subject.board.size).to eq 12
    end
    it "starts with 69 cards in the deck" do
      expect(subject.deck.size).to eq 69
    end

  end

  describe "#board" do
    it "returns an array of cards" do
      expect(subject.board.all? { |card| card.instance_of? Card } ).to be true
    end
  end

  describe "#deck" do
    it "returns an array of cards" do
      expect(subject.deck.all? { |card| card.instance_of? Card } ).to be true
    end
  end

end
