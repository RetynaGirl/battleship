# frozen_string_literal: true

require './lib/ship'
require './lib/cell'
require './lib/board'

# Displays player board
class Player
  attr_reader :board, :ships, :shots

  def initialize(ship_names: { 'Submarine' => 2, 'Cruiser' => 3 }, board_size: 4)
    @board = Board.new(board_size)
    @ships = generate_player_ships(ship_names)
    @shots = []
  end

  def generate_player_ships(ship_names)
    ship_names.map do |name, length|
      Ship.new(name, length)
    end
  end

  def player_place_ship(ship, coords)
    @board.place(ship, coords)
  end

  def valid_sequence?(ship, coords)
    @board.valid_placement?(ship, coords)
  end

  def lost?
    @ships.all?(&:sunk?)
  end
end
