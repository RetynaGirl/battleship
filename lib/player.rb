# frozen_string_literal: true

require './lib/ship'
require './lib/cell'
require './lib/board'

# Displays player board
class Player
  attr_reader :board, :ships, :shots, :interface

  def initialize(ship_names, board_size, interface)
    @board = Board.new(board_size)
    @ships = generate_ships(ship_names)
    @interface = interface
    @shots = []
  end

  def generate_ships(ship_names)
    ship_names.map do |name, length|
      Ship.new(name, length)
    end
  end

  def place_ship(ship, coords)
    @board.place(ship, coords)
  end

  def ship_placement_coords
    @interface.place_ship(@ship, @board)
  end

  def lost?
    @ships.all?(&:sunk?)
  end

  def shot_coordinate(other_board)
    coord = interface.shot_position(other_board, @shots)
    @shots << coord
    coord
  end

  def fire_upon(coord)
    @board.cells[coord].fire_upon
  end
end
