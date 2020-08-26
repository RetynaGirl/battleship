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
end
