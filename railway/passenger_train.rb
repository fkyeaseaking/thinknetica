class PassengerTrain < Train
  init_instances

  def initialize(number)
    super
    @type = :passenger
  end
end
