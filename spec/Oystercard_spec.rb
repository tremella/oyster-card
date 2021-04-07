require 'oystercard'

describe Oystercard do

  let (:default_balance) { Oystercard::DEFAULT_BALANCE }
  let (:max_balance) { Oystercard::MAX_BALANCE }
  # let (:test_plane) { Plane.new }
  describe '#balance' do
    it 'responds' do
      expect(subject).to respond_to(:balance)
    end

    it 'returns default balance' do
      expect(subject.balance).to eq(default_balance)
    end
  end

  describe '#deduct' do
    it 'responds' do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it '#deduct reduces balance' do
      expect { subject.deduct 20 }.to change {subject.balance }.by -20
    end
  end

  describe '#top_up' do
    it 'responds' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it '#top up increases balance' do
      ## sum = 10
      ## subject.top_up(sum)
      ## expect(subject.balance).to eq(default_balance+sum)
      # more elegant alternative:
      expect { subject.top_up 20 }.to change {subject.balance }.by 20
    end

    it '#top up will not permit exceeding max balance' do
      sum = max_balance
      expect { subject.top_up(sum) }.to raise_error("max balance of #{max_balance} exceeded")
    end
  end

  describe '#deduct' do
    it { expect(subject).to respond_to(:deduct).with(1).argument }

    it 'reduces balance' do
      sum = 30
      expect(subject.deduct(sum)).to eq(default_balance - sum)
    end
  end

  describe '#in_journey' do
    it 'will respond to #in_journey' do
      expect(subject).to respond_to(:in_journey)
    end

    it 'by default, is not in a journey' do
      expect(subject.in_journey).to eq(false)
      # expect(subject).to be_in_journey
      # revisit walkthrough to try this way
    end
  end

  describe '#touch_in' do
    it 'will respond to #touch_in' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'will change #in_journey to true' do
      subject.touch_in
      expect(subject.in_journey).to eq(true)
    end

  end
  describe '#touch_out' do
    it 'will respond to #touch_out' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'will change #in_journey to true' do
      subject.touch_out
      expect(subject.in_journey).to eq(false)
    end

  end

end
