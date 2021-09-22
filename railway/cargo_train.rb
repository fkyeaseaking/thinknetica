class CargoTrain < Train
  init_instances

  def initialize(number)
    super
    @type = :cargo
  end
end
