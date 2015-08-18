require 'rails_helper'

RSpec.describe CardSet, type: :model do

  let(:red)    { double("card", attributes: { color: :red    }) }
  let(:yellow) { double("card", attributes: { color: :yellow }) }
  let(:blue)   { double("card", attributes: { color: :blue   }) }

  it { is_expected.to validate_presence_of :cards }

  it "validates a set" do
    expect(CardSet.new(cards: [red, yellow, blue])).to       be_valid
    expect(CardSet.new(cards: [red, red,    red])).to        be_valid
    expect(CardSet.new(cards: [red, yellow, yellow])).not_to be_valid
  end

  it "validates cards length" do
    expect(CardSet.new(cards: [])).not_to              be_valid
    expect(CardSet.new(cards: [red, yellow, blue])).to be_valid
  end

end
