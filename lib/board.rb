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

  def valid_coordinate?(coordinate)
    @cells.key?(coordinate)
  end
end
