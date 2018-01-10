class Journey
  attr_reader :start_station
  attr_reader :end_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def start(station)
    @start_station = station
  end

  def finish(station)
    @end_station = station
  end

  def fare
    PENALTY_FARE if penalty?
    MINIMUM_FARE
  end

  private
  def penalty?
    @start_station.nil? || @end_station.nil?
  end
end
