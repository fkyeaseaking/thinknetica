class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    stations.insert(@stations.size - 1, station)
  end

  def remove_station(station)
    stations.delete(station)
  end
end
