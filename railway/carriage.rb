require_relative "company_mixin"

class Carriage
  include CompanyMixin

  attr_reader :type, :place, :used_place
  attr_accessor :number

  ERRORS = {
    all_seats_taken: "All seats taken",
    not_enough_space: "Not enough space"
  }.freeze

  def initialize(place)
    @place = place
    @used_place = 0
    @number = rand(1..1000)
  end

  def free_place
    place - used_place
  end
end
