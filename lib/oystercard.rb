require_relative 'station'

class Oystercard

  attr_reader :balance, :max_balance, :entry_station, :exit_station, :previous_journeys#, :in_journey
  DEFAULT_BALANCE = 1
  MAX_BALANCE = 90
  MIN_FARE = 2

  def initialize
    @balance = DEFAULT_BALANCE
    @max_balance = MAX_BALANCE
    # @in_journey = false #**
    @min_fare = MIN_FARE
    @entry_station = nil
    @exit_station = nil
    @previous_journeys = [] #+[entry,exit]
  end

  def top_up(sum)
    fail "max balance of #{max_balance} exceeded" if balance_exceeded?(sum)
    @balance += sum
  end

  # def deduct(sum)
  #   @balance -= sum
  # end

  def in_journey?
    @entry_station == nil ? false : true
  end

  def touch_in(station)
    fail "Insufficient funds, your balance is less than #{MIN_FARE}" if @balance < MIN_FARE
    # @in_journey = true
    @exit_station = nil
    @entry_station = station
  end

  def touch_out(station)
    @previous_journeys << {:entry => entry_station, :exit => station}
    @balance -= @min_fare
    @entry_station = nil
    @exit_station = station
  end

  private

  def deduct(sum)
    @balance -= sum
  end

  def balance_exceeded?(sum)
    @balance+sum > @max_balance
  end

end
