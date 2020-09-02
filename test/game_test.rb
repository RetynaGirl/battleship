# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/game'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_determine_winner
    game = Game.new

    player_mock = mock('player')
    computer_mock = mock('computer')

    player_mock.stubs('lost?').returns(true)
    computer_mock.stubs('lost?').returns(true)

    game.player = player_mock
    game.computer = computer_mock

    game.expects('puts').at_least(1)

    game.display_winner
  end

  def test_run_game
    game = Game.new

    game.stubs('game_setup')
    game.stubs('game_loop')

    game.expects('game_setup').once
    game.expects('game_loop').once

    game.play_game
  end
end
