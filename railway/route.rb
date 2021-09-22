require_relative "instance_counter.rb"

class Route
  include InstanceCounter

  attr_reader :stations

  init_instances

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    register_instance
  end

  def add_station(station)
    stations.insert(@stations.size - 1, station)
  end

  def remove_station(station)
    stations.delete(station)
  end
end
