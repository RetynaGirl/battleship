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

    # Not diagonal
    assert_equal false, board.valid_placement?(cruiser, %w[A1 B2 C3])
    assert_equal false, board.valid_placement?(submarine, %w[C2 D3])

    # Should work
    assert board.valid_placement?(submarine, %w[A1 A2])
    assert board.valid_placement?(cruiser, %w[B1 C1 D1])
  end

  def test_coordinate_valid
    board = Board.new

    assert_equal true, board.valid_coordinate?('A1')
    assert_equal true, board.valid_coordinate?('D4')
    assert_equal false, board.valid_coordinate?('A5')
    assert_equal false, board.valid_coordinate?('A22')
  end

  def test_it_places_ship
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)

    board.place(cruiser, %w[A1 A2 A3])
    cell1 = board.cells['A1']
    cell2 = board.cells['A2']
    cell3 = board.cells['A3']

    assert_equal cruiser, cell1.ship
    assert_equal cruiser, cell2.ship
    assert_equal cruiser, cell3.ship
    assert_equal true, cell3.ship == cell2.ship
  end

  def test_if_it_overlaps
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)

    board.place(cruiser, %w[A1 A2 A3])
    submarine = Ship.new('Submarine', 2)

    assert_equal false, board.valid_placement?(submarine, %w[A1 B1])
  end

  def test_board_renders
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)

    board.place(cruiser, %w[A1 A2 A3])

    expected1 = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    expected2 = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    # No ships
    assert_equal expected1, board.render

    # Show ships
    assert_equal expected2, board.render(true)

    # Hits and Misses
    board.cells['B4'].fire_upon
    board.cells['A1'].fire_upon

    expected3 = "  1 2 3 4 \nA H . . . \nB . . . M \nC . . . . \nD . . . . \n"

    assert_equal expected3, board.render

    # Sunk ship and show ship
    submarine = Ship.new('Submarine', 2)

    board.place(submarine, %w[C1 D1])

    board.cells['C1'].fire_upon
    board.cells['D1'].fire_upon

    expected4 = "  1 2 3 4 \nA H S S . \nB . . . M \nC X . . . \nD X . . . \n"

    assert_equal expected4, board.render(true)
  end
end
