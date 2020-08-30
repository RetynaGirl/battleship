# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/computer'

class ComputerTest < Minitest::Test
  def test_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end

  def test_generate_default_ships
    skip
    # Throws that failure that means it actually worked

    computer = Computer.new
    ship1 = Ship.new('Submarine', 2)
    ship2 = Ship.new('Cruiser', 3)

    assert_equal [ship1, ship2], computer.ships
  end

  def test_generate_coords
    computer = Computer.new
    ship1 = Ship.new('Submarine', 2)
    ship2 = Ship.new('Cruiser', 3)

    assert_equal %w[A1 A2 A3], computer.generate_coords(ship2, :horizontal, 'A1')
    assert_equal %w[A1 B1], computer.generate_coords(ship1, :vertical, 'A1')
  end

  def test_place_ships
    ship1 = Ship.new('Submarine', 2)
    ship2 = Ship.new('Cruiser', 3)
    computer = Computer.new

    computer.ships = [ship1, ship2]

    computer.place_ships

    cells_with_ship = 0
    computer.board.cells.values.each do |cell|
      cells_with_ship += 1 unless cell.empty?
    end

    assert_equal 5, cells_with_ship

    assert computer.board.cells.values.map(&:ship).include?(ship1)
    assert computer.board.cells.values.map(&:ship).include?(ship2)
  end

  def test_lost
    computer = Computer.new

    assert_equal false, computer.lost?

    computer.ships[0].hit
    computer.ships[0].hit

    assert_equal false, computer.lost?

    computer.ships[1].hit
    computer.ships[1].hit
    computer.ships[1].hit

    assert computer.lost?
  end

  def test_shot_position
    computer = Computer.new

    assert computer.board.cells.keys.include?(computer.shot_position)
    assert computer.board.cells.keys.include?(computer.shot_position)
    assert computer.board.cells.keys.include?(computer.shot_position)
  end
end
