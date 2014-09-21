require 'hanoi'

describe Hanoi do
  subject(:game) {Hanoi.new}
  it "contains 3 arrays" do
    expect(game.stacks.count).to eq(3)
  end

  it "all disks start in the left stack" do
    expect(game.stacks[0]).to eq([1,2,3])
    expect(game.stacks[1..2].all?(&:empty?)).to be true
  end

  context "Moves" do

    it "allows moves" do
      game.move(0,1)
      expect(game.stacks[0]).to eq([2,3])
      expect(game.stacks[1]).to eq([1])
    end

    it "doesn't allow moving a larger piece onto a smaller one" do
      game.move(0,1)
      expect { game.move(0,1) }.to raise_error(InvalidMoveError)
    end

    it "doesn't allow moving a larger piece onto a smaller one" do
      game.move(0,1)
      expect { game.move(1, 0) }.not_to raise_error
    end

  end

  context "Victory" do
    it "can tell when you've won" do
      game.stacks[0..-1] = [[], [], [1,2,3]]
      expect(game.won?).to be true
    end

    it "can tell when you haven't won" do
      expect(game.won?).to be false
    end
  end

  context "UI" do

    it "asks user for input" do
      allow(game).to receive(:gets)
      expect(game).to receive(:gets)
      game.play
    end

    it "asks user to select from and to stacks" do
      allow(game).to receive(:puts)
      expect(game).to receive(:puts).with('Please choose to and from stacks.')
      game.play
    end
  end
end

