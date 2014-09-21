require 'rspec'
require 'arrays'

describe "#my_uniq" do
  subject { [1, 2, 1, 3, 3] }

  it "responds to method" do
    expect(subject).to respond_to(:my_uniq)
  end

  it "removes duplicate elements" do
    expect(subject.my_uniq).to eq([1,2,3])
  end
end

describe "#two_sum" do
  subject { [-1, 0, 2, -2, 1] }

  it "returns pairs of indices that sum to zero" do
    expect(subject.two_sum).to match_array([[2, 3], [0, 4]])
  end

  it "returns pairs sorted dictionary-wise" do
    expect(subject.two_sum).to eq( [[0, 4], [2, 3]] )
  end

end

describe "#my_transpose" do
  subject {
    [[0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]]
  }

  let(:transpose) {
    [[0, 3, 6],
     [1, 4, 7],
     [2, 5, 8]]
  }

  it "transposes an array" do
    expect(my_transpose(subject)).to eq(transpose)
  end

end

describe "#stock_picker" do
  let(:prices) { [1, 2, 4, 1, 5, 6, 2, 4, 6] }

  it "outputs the most profitable set of days" do
    expect(stock_picker(prices)).to eq([0, 5])
  end
end

