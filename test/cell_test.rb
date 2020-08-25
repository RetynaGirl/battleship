# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'
require './lib/cell.rb'

class CellTest < Minitest::Test
  def test_it_exists
    cell = Cell.new('B4')

    assert_instance_of Cell, cell
  end

  def test_attributes
    cell = Cell.new('B4')

    assert_equal 'B4', cell.coordinate
    assert_nil cell.ship
  end

  def test_it_returns_empty?
    cell = Cell.new('B4')
    ship = Ship.new('Cruiser', 3)

    assert cell.empty?

    cell.place_ship(ship)

    assert !cell.empty?
  end

  def test_can_place_ship
    cell = Cell.new('B4')
    ship = Ship.new('Cruiser', 3)

    cell.place_ship(ship)

    assert_equal ship, cell.ship
  end

  def test_fired_upon?
    cell = Cell.new('B4')
    ship = Ship.new('Cruiser', 3)

    cell.place_ship(ship)

    assert !cell.fired_upon?

    cell.fire_upon

    assert_equal 2, cell.ship.health
    assert cell.fired_upon?
  end

  def test_render_no_ship
    cell = Cell.new('B4')

    assert_equal '.', cell.render
    assert_equal '.', cell.render(true)

    cell.fire_upon

    assert_equal 'M', cell.render
  end

  def test_render_ship
    cell = Cell.new('B4')
    ship = Ship.new('Cruiser', 3)

    cell.place_ship(ship)

    assert_equal '.', cell.render
    assert_equal 'S', cell.render(true)

    cell.fire_upon

    assert_equal 'H', cell.render

    ship.hit
    ship.hit

    assert_equal 'X', cell.render
  end
end
