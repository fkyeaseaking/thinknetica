require_relative "company_mixin.rb"

class Carriage
  include CompanyMixin

  attr_reader :type
  attr_accessor :number

  ERRORS = {
    all_seats_taken: "All seats taken",
    not_enough_space: "Not enough space"
  }

  def initialize
    @number = rand(1..1000)
  end
end
