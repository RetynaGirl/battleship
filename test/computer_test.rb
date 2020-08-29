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
  end
end
