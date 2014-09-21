class Hanoi

  attr_reader :stacks

  def initialize
    @stacks = [[1, 2, 3],[],[]]
  end

  def play
    puts "Please choose to and from stacks."
    gets
  end

  def move(from_stack, to_stack)
    if !@stacks[to_stack].empty? && (@stacks[to_stack].first < @stacks[from_stack].first)
      raise InvalidMoveError
    end
    @stacks[to_stack] << @stacks[from_stack].shift
  end

  def won?
    @stacks == [[], [], [1, 2, 3]]
  end

end

class InvalidMoveError < StandardError
end