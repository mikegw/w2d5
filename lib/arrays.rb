class Array
  def my_uniq
    self.inject([]) do |mem, el|
      mem.include?(el) ? mem : mem << el
    end
  end

  def two_sum
    a = []
    self.each_index do |index|
      ((index + 1)...self.length).each do |index2|
        a << [index, index2] if self[index] + self[index2] == 0
      end
    end
    a
  end

end

def my_transpose(matrix)
  transpose = Array.new(matrix.length){Array.new(matrix.length)}
  transpose.length.times do |row|
    transpose.length.times do |col|
      transpose[row][col] = matrix[col][row]
    end
  end
  transpose
end

def stock_picker(prices)
  best_profit = 0
  indices = []

  prices.each_index do |buy|
    (buy + 1...prices.length).each do |sell|
      profit = prices[sell] - prices[buy]

      if profit > best_profit
        indices = [buy, sell]
        best_profit = profit
      end
    end
  end

  indices
end