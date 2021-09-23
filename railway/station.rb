require_relative "instance_counter.rb"

class Station
  include InstanceCounter

  attr_reader :name, :trains

  init_instances

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    @@stations << self
  end

  def self.all
    @@stations
  end

  def add_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end
end
