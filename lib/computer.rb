# frozen_string_literal: true

require './lib/ship'
require './lib/board'

# Holds data and helpful methods for the Computer player
class Computer
  attr_reader :shots
  attr_accessor :board, :ships # Accessor for test only

  def place_ship(ship, board)
    direction = %i[horizontal vertical].sample
    coord = board.cells.keys.sample

    generate_coords(ship, direction, coord)
  end

  def generate_coords(ship, direction, coord)
    coord_data = [coord[0], coord[1..-1]]

    (1..ship.length).map do |num|
      case direction
      when :horizontal
        "#{coord_data[0]}#{(coord_data[1].to_i + (num - 1))}"
      when :vertical
        "#{(coord_data[0].ord + (num - 1)).chr}#{coord_data[1]}"
      end
    end
  end

  def shot_position(other_board, completed_shots)
    coord = other_board.cells.keys.sample
    coord = other_board.cells.keys.sample while completed_shots.include?(coord)
    coord
  end
end
