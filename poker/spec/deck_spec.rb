require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.full_deck }

  context "creating the deck" do
    it "Initializes with 52 cards" do
      expect(deck.count).to eq(52)
    end

    it "Has 52 unique cards" do
      expect(deck.draw(52).uniq.count).to eq(52)
    end
  end

  context "passing cards to and from the deck" do
    let(:dummy_deck) { Deck.new([1, 2, 3]) }

    it "Can draw cards" do
      expect(deck).to respond_to(:draw)
    end

    it "returns the drawn cards" do
      expect(dummy_deck.draw(2)).to match_array([2, 3])
    end

    it "Drawn cards are removed from the deck" do
      deck.draw(1)
      expect(deck.count).to eq(51)
    end

    it "can put returned cards on the bottom of the deck" do
      hand = deck.draw(5)
      deck.return(hand)
      expect(deck.count).to eq(52)
    end

    it "can't keep drawing cards once empty" do
      deck.draw(52)
      expect { deck.draw(1) }.to raise_error(OutOfCardsError)
    end

    let(:extra_card) { double(:card, :value => :king, :suit => :anchors) }

    it "Won't return more cards when the deck is full" do

      expect { deck.return([extra_card]) }.to raise_error
    end

    let(:double_card) { double(:card, :value => :king, :suit => :spades) }

    it "Won't return a card it already contains" do
      deck.draw(1)
      expect { deck.return([double_card]) }.to raise_error
    end

  end

  context "playing with the deck" do

    it "should be able to shuffle itself" do
      expect(deck.instance_variable_get(:@deck)).to receive(:shuffle!)
      deck.shuffle!
    end

  end


end