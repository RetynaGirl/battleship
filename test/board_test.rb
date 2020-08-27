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
end
