# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/player'
require './lib/turn'
require './lib/computer'

class TurnTest < Minitest::Test
  def test_it_exists
    player = Player.new
    computer = Computer.new
    turn = Turn.new(player, computer)

    assert_instance_of Turn, turn
  end
end
