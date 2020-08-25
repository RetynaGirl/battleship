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
end
