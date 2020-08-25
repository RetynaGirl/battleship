# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship.rb'

class ShipTest < Minitest::Test
  def test_it_exists
    ship = Ship.new('Cruiser', 3)

    assert_instance_of Ship, ship
  end

  def test_attributes_exist
    ship = Ship.new('Cruiser', 3)

    assert_equal "Cruiser", ship.name
    assert_equal 3, ship.length
    assert_equal 3, ship.health
  end

  def test_is_sunk
    ship = Ship.new('Cruiser', 3)

    assert_equal false, ship.sunk?

    ship.hit
    ship.hit
    ship.hit

    assert ship.sunk?
  end

  def test_hit
    ship = Ship.new('Cruiser', 3)

    ship.hit
    assert_equal 2, ship.health
    ship.hit
    assert_equal 1, ship.health
  end
end
