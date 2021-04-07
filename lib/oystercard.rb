class Oystercard
  attr_reader :balance, :max_balance

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  def initialize
    @balance = DEFAULT_BALANCE
    @max_balance = MAX_BALANCE
  end

  def top_up(sum)
    fail "max balance of #{max_balance} exceeded" if balance_exceeded?(sum)
    @balance += sum
  end

  def deduct(sum)
    @balance -= sum
  end

  private

  def balance_exceeded?(sum)
    @balance+sum > @max_balance
  end

end
