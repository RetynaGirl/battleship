# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/player'

class TurnTest < Minitest::Test
  def test_it_exists
    turn = Turn.new(player, computer)

    assert_instance_of Turn, turn
  end
end
