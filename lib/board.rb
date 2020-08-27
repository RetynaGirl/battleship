# frozen_string_literal: true

require './lib/ship'
require './lib/cell'

# Displays the game board
class Board
  attr_reader :cells
  def initialize(board_size = 4)
    @board_size = board_size
    @cells = create_cells
  end

  def create_cells
    cells = {}
    letters = (65..(@board_size + 64)).map(&:chr)
    numbers = (1..@board_size)

    letters.each do |letter|
      numbers.each do |number|
        position = letter + number.to_s
        cells[position] = Cell.new(position)
      end
    end
    cells
  end

  def valid_placement?(ship, coordinates)
    coordinates.each do |coord|
      return false unless valid_coordinate?(coord)
    end
    return false if ship_overlaps?(coordinates)

    return false unless ship.length == coordinates.length

    if ship.length > 1
      direction = determine_direction(coordinates)
      return false if direction == false

      return validate_direction(coordinates, direction)
    end
    true
  end

  def validate_direction(coordinates, direction)
    first_coords = coordinates[0].split('')

    coordinates.each_with_index do |coords, idx|
      split_coords = coords.split('')

      case direction
      when :vertical
        return false unless first_coords[0].ord + idx == split_coords[0].ord && first_coords[1] == split_coords[1]
      when :horizontal
        return false unless first_coords[1].to_i + idx == split_coords[1].to_i && first_coords[0] == split_coords[0]
      end
    end
    true
  end

  def determine_direction(coordinates)
    first_coords = coordinates[0].split('')
    second_coords = coordinates[1].split('')

    if first_coords[0] == second_coords[0] && first_coords[1] != second_coords[1]
      :horizontal
    elsif first_coords[0] != second_coords[0] && first_coords[1] == second_coords[1]
      :vertical
    else
      false
    end
  end

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end

  def place(ship, coordinates)
    return unless valid_placement?(ship, coordinates)

    coordinates.each { |coord| @cells[coord].place_ship(ship) }
  end

  def ship_overlaps?(coordinates)
    coordinates.each do |coord|
      return true unless @cells[coord].empty?
    end

    false
  end

  def render(show_ships = false)
    letters = (65..(@board_size + 64)).map(&:chr)
    numbers = (1..@board_size)

    out_string = '  '

    numbers.each do |num|
      out_string += "#{num} "
    end
    out_string += "\n"

    letters.each do |letter|
      out_string += letter

      numbers.each do |num|
        out_string += " #{@cells[letter + num.to_s].render(show_ships)}"
      end

      out_string += " \n"
    end
    out_string
  end
end
