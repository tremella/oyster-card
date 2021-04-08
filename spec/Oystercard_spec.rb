require 'oystercard'

describe Oystercard do

  let (:default_balance) { Oystercard::DEFAULT_BALANCE }
  let (:max_balance) { Oystercard::MAX_BALANCE }
  let (:min_fare) { Oystercard::MIN_FARE }
  let (:station){ double :station } #equal to Station.new
  let (:entry_station){ double :station } #equal to Station.new
  let (:exit_station){ double :station } #equal to Station.new

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

  describe '#in_journey' do
    it { expect(subject).to respond_to(:in_journey?) }
    # a faster version of this  vvv
    # it 'will respond to #in_journey' do
    #   expect(subject).to respond_to(:in_journey?)
    # end

    it 'by default, entry station is nil' do
      expect(subject.in_journey?).to eq(false)
      # expect(subject).to be_in_journey
      # revisit walkthrough to try this way
    end
  end
  # needs to account for (station) arg
  describe '#touch_in' do
    it 'will respond to #touch_in' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it 'prompts #in_journey to return true' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'Raises an error if balance is less than £1' do
      expect{ subject.touch_in(entry_station) }.to raise_error("Insufficient funds, your balance is less than #{min_fare}")
    end

    it 'stores the entry station' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

  end
  # needs to account for (station) arg
  describe '#touch_out' do
    it 'will respond to #touch_out' do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    it 'will change entry station to nil on touch out' do
      expect(subject.touch_out(exit_station)).to eq(exit_station)
    end

    #test to reduce balance by min fare
    it 'will deduct min fare from balance at end of trip' do
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by -min_fare
    end

    it 'pend, pendulum, pendleton ward, perpendicular, pending.'


  end

  describe 'previous_journeys' do
    it { expect(subject).to respond_to(:previous_journeys) }

    it { expect(subject.previous_journeys).to be_empty }
  end


  it 'stores previous journey' do
    subject.top_up(20)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.previous_journeys).to include({:entry => entry_station, :exit => exit_station})
  end




  # [
  # {
  #   entry station: "liverpool street",
  #   exit station : "cork street"
  # }
  # ]

end
