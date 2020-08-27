# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_cells
    board = Board.new(4)

    assert_instance_of Hash, board.cells
    assert_equal 16, board.cells.length

    board.cells.each do |position, cell|
      assert_instance_of String, position
      assert_instance_of Cell, cell
    end
  end

  def test_validate_ships
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)

    # Same length
    assert_equal false, board.valid_placement?(cruiser, %w[A1 A2])
    assert_equal false, board.valid_placement?(submarine, %w[A1 A2 A3])

    # Consecutive
    assert_equal false, board.valid_placement?(cruiser, %w[A1 A2 A4])
    assert_equal false, board.valid_placement?(submarine, %w[A1 C1])
    assert_equal false, board.valid_placement?(cruiser, %w[A3 A2 A1])
    assert_equal false, board.valid_placement?(submarine, %w[C1 B1])
  end
end
