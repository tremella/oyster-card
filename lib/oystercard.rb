class Oystercard

  attr_reader :balance, :max_balance, :in_journey, :entry_station
  DEFAULT_BALANCE = 1
  MAX_BALANCE = 90
  MIN_FARE = 2

  def initialize
    @balance = DEFAULT_BALANCE
    @max_balance = MAX_BALANCE
    # @in_journey = false #**
    @min_fare = MIN_FARE
    @entry_station = nil
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
    @entry_station = station
  end

  def touch_out
    @balance -= @min_fare
    @entry_station = nil
  end

  private

  def deduct(sum)
    @balance -= sum
  end

  def balance_exceeded?(sum)
    @balance+sum > @max_balance
  end

end
