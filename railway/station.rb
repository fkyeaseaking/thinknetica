require_relative "instance_counter.rb"

class Station
  include InstanceCounter

  attr_reader :name, :trains

  init_instances

  def initialize(name)
    @name = name
    @trains = []
    register_instance
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def add_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end
end
