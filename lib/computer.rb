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

  def place_ships
    @ships.each do |ship|
      direction = %i[horizontal vertical].sample
      coord = @board.cells.keys.sample

      coordinates = generate_coords(ship, direction, coord)
    end
  end

  def generate_coords(ship, direction, coord)
    coord_data = coord.split('')

    (1..ship.length).map do |num|
      case direction
      when :horizontal
        "#{coord_data[0]}#{(coord_data[1].to_i + (num - 1))}"
      when :vertical
        "#{(coord_data[0].ord + (num - 1)).chr}#{coord_data[1]}"
      end
    end
  end
end
