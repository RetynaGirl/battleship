# frozen_string_literal: true

require './lib/ship'
require './lib/board'

# Holds data and helpful methods for the Computer player
class Computer
  attr_reader :ships

  def initialize(ship_names = { 'Submarine' => 2, 'Cruiser' => 3 })
    @board = Board.new
    @ships = generate_ships(ship_names)
  end

  def generate_ships(ship_names)
    ship_names.map do |name, length|
      Ship.new(name, length)
    end
  end
end
