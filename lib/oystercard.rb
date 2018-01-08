class Oystercard
  #controls the user balance

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail_message = "cannot top-up, #{@balance + amount} is greater than limit of #{MAXIMUM_BALANCE}"
    raise fail_message if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

end
