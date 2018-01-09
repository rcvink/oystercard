class Oystercard
  #controls the user balance

  MINIMUM_FARE = 1
  MAXIMUM_BALANCE = 90

  attr_reader :balance
  attr_reader :history

  def initialize
    @balance = 0
    @history = []
  end

  def top_up(amount)
    fail_message = "cannot top-up, #{@balance + amount} is greater than limit of #{MAXIMUM_BALANCE}"
    raise fail_message if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Not enough money on your card' if insufficient_funds?
    store_entry_station(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    store_exit_station(exit_station)
  end

  def in_journey?
    !@current_journey.nil?
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

  def store_entry_station(entry_station)
    @current_journey = {origin: entry_station}
  end

  def store_exit_station(exit_station)
    @current_journey[:destination] = exit_station
    @history << @current_journey
    @current_journey = nil
  end
end
