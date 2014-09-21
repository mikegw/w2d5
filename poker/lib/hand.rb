class Hand
  def self.full_hand(deck)
    Hand.new(deck.draw(5))
  end

  def initialize(cards = [])
    @cards = cards
  end

  def cards
    @cards
  end

  def draw(deck, n)
    # p [@cards, deck.draw(n)]
    @cards += deck.draw(n)
  end

  def discard(deck, n)
    deck.return(@cards.pop(n))
  end

  def values
    @cards.map(&:value)
  end

  def group_by_sets
    groups = values.group_by { |i| @cards.count(i) }
    groups.default = []
    groups
  end

  def find_pair
    pair = group_by_sets[2].uniq.sort
    pair[0] || 0
  end

  def find_two_pair
    pair = group_by_sets[2].uniq.sort
    pair[1] || 0
  end

  def find_triple
    pair = group_by_sets[3].uniq.first
    pair || 0
  end

  def find_quadruple
    pair = group_by_sets[4].uniq.first
    pair || 0
  end

  def group_by_suits
    @cards.group_by { |i| i.suit }
  end

  def find_flush
    groups = group_by_suits
    p groups
    groups.keys.each do |suit|
      return 1 if groups[suit].count == 5
    end
    0
  end

  def find_full_house
    groups = group_by_sets
    p groups
    if !groups[3].empty? and !groups[2].empty?
      return groups[3][0]
    end

    0
  end

  def find_straight
    values = @cards.map(&:value)
    p values
    14.downto(6).each do |top|
      return top if top.downto(top - 4).all?{|v| values.include?(v)}
    end

    0
  end

  def find_straight_flush
    find_straight * find_flush != 0 # only not 0 if both straight and flush
  end

  def calculate_points
    @points = [
      find_straight_flush, find_quadruple, find_full_house,
      find_flush, find_straight, find_triple,
      find_two_pair, find_pair, *(values.sort{|v1, v2| v2.value <=> v1.value})
    ]
  end

  def points
    @points
  end

  def beats?(other)
    return nil
    self.calculate_points
    other.calculate_points
    @points.each_index do|i|
      case self.points[i] <=> other.points[i]
      when -1
        return false
      when 1
        return true
      end
    end
    raise "A draw"
  end

end