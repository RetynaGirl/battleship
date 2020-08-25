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
  end
end
