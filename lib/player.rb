# frozen_string_literal: true

require './lib/ship'
require './lib/cell'
require './lib/board'

# Displays player board
class Player
  attr_reader :board, :ships

  def initialize(ship_names = { 2 => 'Submarine', 3 => 'Cruiser'})
    @board = Board.new
    @ships = generate_player_ships(ship_names)
  end

  def generate_player_ships(ship_names)
    ships = []

    ship_names.each do |length, name|
      ships << Ship.new(name, length)
    end
    ships
  end

  def player_place_ship(ship, coords)
    @board.place(ship, coords)
  end

  def valid_sequence?(ship, coords)
    @board.valid_placement?(ship, coords)
  end
end
