# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/computer'
require 'mocha/minitest'

class ComputerTest < Minitest::Test
  def test_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end

  def test_generate_coords
    computer = Computer.new
    ship1 = Ship.new('Submarine', 2)
    ship2 = Ship.new('Cruiser', 3)

    assert_equal %w[A1 A2 A3], computer.generate_coords(ship2, :horizontal, 'A1')
    assert_equal %w[A1 B1], computer.generate_coords(ship1, :vertical, 'A1')
  end

  def test_place_ship
    ship1 = Ship.new('Submarine', 2)
    ship2 = Ship.new('Cruiser', 3)
    computer = Computer.new

    board = Board.new(1)

    assert [%w[A1 A2], %w[A1 B1]].include?(computer.place_ship(ship1, board))
  end

  def test_shot_position
    computer = Computer.new
    board = Board.new(2)
    completed_shots = %w[A1 B2 B1]

    assert_equal 'A2', computer.shot_position(board, completed_shots)
  end
end
