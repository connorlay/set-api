require 'rails_helper'

RSpec.describe CardSet, type: :model do

  let(:card) { double("card", attributes: { color: :red }) }

  it { is_expected.to validate_presence_of :cards }

  it "validates cards length" do
    expect(CardSet.new(cards: [])).not_to             be_valid
    expect(CardSet.new(cards: [card, card, card])).to be_valid
  end

end
