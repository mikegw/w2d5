require 'rspec'
require 'card'

describe Card do
  let(:card) { Card.new(:king, :spades) }

  it "Can be made with suit and value" do
    expect(card.suit).to eq(:spades)
    expect(card.value).to eq(:king)
  end

  it "raise an error if given an invalid suit" do
    expect { Card.new(:king, :anchors) }.to raise_error(ArgumentError)
  end

  it "raise an error if given an invalid value" do
    expect { Card.new(:duke, :spades) }.to raise_error(ArgumentError)
  end

  it "can compare itself to other cards" do
    other_card1 = Card.new(:king, :spades)
    other_card2 = Card.new(:ace, :spades)
    other_card3 = Card.new(:king, :diamonds)

    expect(card == other_card1).to be true
    expect(card == other_card2).to be false
    expect(card == other_card3).to be false
  end


end