class Oystercard
  #controls the user balance

  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90

  attr_reader :balance
  attr_reader :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail_message = "cannot top-up, #{@balance + amount} is greater than limit of #{MAXIMUM_BALANCE}"
    raise fail_message if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Not enough money on your card' if insufficient_funds?
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  private
  def limit_exceeded?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end
end
