# frozen_string_literal: true

require './lib/ship'
require './lib/cell'
require './lib/board'

# Displays player board
class Player
  attr_reader :player, :ship

  def initialize
    @player = Board.new
    @ship_names = {
      2 => 'Submarine',
      3 => 'Cruiser'
    }
  end

  def generate_player_ships
    ships = []

    @ship_names.each do |length, name|
      ships << Ship.new(name, length)
    end
    ships
  end

  def player_place_ship(ship, coords)
    coords.each do |coord|
      @player.cells[coord].place_ship(ship)
    end
  end

  def valid_sequence?(ship, coords)
    valid = false
    coords.sort
    coords.each do |coord|
      valid = @player.cells.include?(coord) && @player.valid_placement?(ship, coords)
    end
    valid
  end
end
