class PassengerCarriage < Carriage
  def initialize
    super
    @type = :passenger
  end

  def add_passenger
    if used_place < place
      used_place += 1 
    else
      raise ERRORS[:all_seats_taken]
    end
  end
end
