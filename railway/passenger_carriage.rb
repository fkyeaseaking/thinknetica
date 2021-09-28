class PassengerCarriage < Carriage
  def initialize
    super
    @type = :passenger
  end

  def add_passenger
    raise ERRORS[:all_seats_taken] unless used_place < place

    used_place += 1
  end
end
