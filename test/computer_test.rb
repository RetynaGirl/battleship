# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/computer'

class ComputerTest < Minitest::Test
  def test_exists
    computer = Computer.new

    assert_instance_of Computer, computer
  end
end
