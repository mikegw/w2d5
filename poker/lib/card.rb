# -*- coding: utf-8 -*-

# Represents a playing card.
class Card
  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  # Returns an array of all suits.
  def self.suits
    SUIT_STRINGS.keys
  end

  # Returns an array of all values.
  def self.values
    VALUE_STRINGS.keys
  end

  attr_reader :value, :suit

  def initialize(value, suit)
    unless VALUE_STRINGS.has_key?(value)
      raise ArgumentError.new("Not a real value!")
    end

    unless SUIT_STRINGS.has_key?(suit)
      raise ArgumentError.new("Not a real suit!")
    end

    @value = value
    @suit = suit
  end

  def ==(other_card)
    self.value == other_card.value && self.suit == other_card.suit
  end
end