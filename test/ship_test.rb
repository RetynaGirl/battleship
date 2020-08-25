# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require 'ship.rb'

class ShipTest < Minitest::Test
  def test_it_exists
    ship = Ship.new('Cruiser', 3)

    assert_instance_of Ship, ship
  end
end
