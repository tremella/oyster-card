require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'responds' do
      expect(subject).to respond_to(:balance)
    end
  end
end
