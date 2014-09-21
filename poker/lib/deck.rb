require_relative 'card'

class OutOfCardsError < StandardError
end

class Deck
  def self.full_deck
    deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        deck << Card.new(value, suit)
      end
    end
    Deck.new(deck)
  end

  def initialize(deck = [])
    @deck = deck
  end

  def count
    @deck.count
  end

  def draw(num)
    raise OutOfCardsError if self.count < num
    @deck.pop(num)
  end

  def return(cards)
    raise ArgumentError if cards.count + @deck.count > 52
    raise ArgumentError if cards.any? { |card| @deck.include?(card) }
    @deck.unshift(*cards)
  end

  def shuffle!
    @deck.shuffle!
  end

end