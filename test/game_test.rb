# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/player'
require './lib/computer'

class GameTest < Minitest::Test
  def test_it_exists
    player = Player.new
    computer = Computer.new

    game = Game.new(player, computer)

    assert_instance_of Game, game
  end
end
