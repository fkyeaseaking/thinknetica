class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def display_trains
    @trains.each { |train| puts train.number }
  end

  def display_trains_by_type(type)
    @trains.each { |train| train if train.type == type }
  end
end
