require 'rails_helper'

RSpec.describe Card do

  describe "#set?" do

    context "with a valid set" do
      let(:card1) { Card.new symbol: :diamond, number: :one, color: :red, shading: :solid }
      let(:card2) { Card.new symbol: :diamond, number: :one, color: :green, shading: :striped }
      let(:card3) { Card.new symbol: :diamond, number: :one, color: :purple, shading: :open }

      it "returns true" do
        expect(card1.set?(card2, card3)).to be true
        expect(card2.set?(card1, card3)).to be true
        expect(card3.set?(card2, card1)).to be true
      end

    end

    context "with an invalid set" do
      let(:card1) { Card.new symbol: :diamond, number: :one, color: :red, shading: :solid }
      let(:card2) { Card.new symbol: :diamond, number: :one, color: :green, shading: :striped }
      let(:card3) { Card.new symbol: :sguiggle, number: :two, color: :purple, shading: :open }

      it "returns false" do
        expect(card1.set?(card2, card3)).to be false
        expect(card2.set?(card1, card3)).to be false
        expect(card3.set?(card2, card1)).to be false
      end
    end
  end
end
