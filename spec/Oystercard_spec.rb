require 'oystercard'

describe Oystercard do

  let (:default_balance) {Oystercard::DEFAULT_BALANCE}
  let (:max_balance) {Oystercard::MAX_BALANCE}
  # let (:test_plane) { Plane.new }
  describe '#balance' do
    it 'responds' do
      expect(subject).to respond_to(:balance)
    end

    it 'returns default balance' do
      expect(subject.balance).to eq(default_balance)
    end
  end

  describe '#top_up' do
    it 'responds' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'top up increases balance' do
      sum = 10
      subject.top_up(sum)
      expect(subject.balance).to eq(default_balance+sum)
    end

    it 'top up increases balance' do
      sum = max_balance
      expect { subject.top_up(sum) }.to raise_error("max balance of #{max_balance} exceeded")
    end

  end
end
