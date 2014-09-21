require 'rspec'
require 'hand'

describe Hand do
  let(:not_really_a_deck) { double(:deck) }
  let(:full_hand) { Hand.full_hand(not_really_a_deck) }
  let(:hand) { Hand.new } #empty hand

  before(:each) do
    not_really_a_deck.stub(:draw) { |n| (1..n).to_a }
    not_really_a_deck.stub(:return).with(instance_of(Array))
  end

  it "Should be able to create a hand with five cards" do
    expect(full_hand.cards.count).to eq(5)
  end

  it "Should be able to draw" do
    expect(not_really_a_deck).to receive(:draw)
    hand.draw(not_really_a_deck, 3)
    expect(hand.cards.count).to eq(3)
  end


  it "Should be able to put back cards" do
    expect(not_really_a_deck).to receive(:return).with([2, 3, 4, 5])
    full_hand.discard(not_really_a_deck, 4)
    expect(full_hand.cards.count).to eq(1)
  end

  context "Should be able to find hands" do

    before(:each) do
      class Fixnum
        def value
          self
        end
      end
    end

    it "find pair" do
      hand = Hand.new([1, 2, 2, 4, 3])
      expect(hand.find_pair).to eq(2)
    end

    it "gives the smaller of two pairs as a pair" do
      hand = Hand.new([1, 2, 2, 3, 3])
      expect(hand.find_pair).to eq(2)
    end

    it "recognizes a two pair" do
      hand = Hand.new([1, 2, 2, 3, 3])
      expect(hand.find_two_pair).to eq(3)
    end

    it "find three-of-a-kind" do
      hand = Hand.new([7, 8, 3, 8, 8])
      expect(hand.find_triple).to eq(8)
    end

    it "find four-of-a-kind" do
      hand = Hand.new([7, 7, 7, 7, 8])
      expect(hand.find_quadruple).to eq(7)
    end

    let(:a_heart) { double(:heart, :suit => :hearts) }
    let(:a_spade) { double(:spade, :suit => :spades) }

    it "recognize a flush" do
      hand = Hand.new([a_heart] * 5)
      expect(hand.find_flush).to eq(1)
      hand = Hand.new([a_spade] * 5)
      expect(hand.find_flush).to eq(1)
    end

    it "doesn't wrongly recognize a flush" do
      hand = Hand.new([a_heart] * 3 + [a_spade] * 2)
      expect(hand.find_flush).to eq(0)
    end

    it "recognize a full house" do
      hand = Hand.new([7, 8, 7, 8, 8])
      expect(hand.find_full_house).to eq(8)
    end

    it "doesn't wrongly recognize a full house" do
      hand = Hand.new([7, 8, 3, 6, 8])
      expect(hand.find_full_house).to eq(0)
    end

    it "recognize a straight" do
      hand = Hand.new([3,4,5,6,7])
      expect(hand.find_straight).to eq(7)
    end

  end

  context "Should be able to compare hands" do
    let(:card1) {double :card, :suit => :hearts, :value => 5}
    let(:card2) {double :card, :suit => :spades, :value => 5}
    let(:card3) {double :card, :suit => :hearts, :value => 6}
    let(:card4) {double :card, :suit => :spades, :value => 7}
    let(:card5) {double :card, :suit => :hearts, :value => 8}
    let(:card6) {double :card, :suit => :spades, :value => 9}
    let(:card7) {double :card, :suit => :spades, :value => 2}


    it "compares boring hands" do
      hand1 = Hand.new([card1, card3, card4, card5, card7])
      hand2 = Hand.new([card1, card3, card4, card6, card7])
      expect(hand1.beats?(hand2)).to be false
      expect(hand2.beats?(hand1)).to be true
    end

    it "compares interesting hands" do
      hand2 = Hand.new([card1, card2, card4, card5, card7])
      hand1 = Hand.new([card2, card3, card4, card6, card5])
      expect(hand1.beats?(hand2)).to be true
      expect(hand2.beats?(hand1)).to be false
    end
  end
end