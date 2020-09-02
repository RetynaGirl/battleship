# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/player'
require './lib/computer'
require './lib/init'
require './lib/user_interface'
require 'mocha/minitest'

class InitTest < Minitest::Test
  def test_it_exists
    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, UserInterface)
    computer = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, Computer)

    init = Init.new(player, computer)

    assert_instance_of Init, init
  end

  def test_board_size
    Init.stubs('gets').returns('-1', '0', '3')

    assert_equal 3, Init.custom_board_size
  end

  def test_custom_ship
    UserInterface.stubs('custom_ship_input').returns(['blah', 2])

    expected = { 'blah' => 2 }
    assert_equal expected, Init.custom_ship({}, 4)
  end

  def test_custom_game_init
    Init.stubs('custom_board_size').returns(4)
    UserInterface.stubs('custom_ship_input').returns(['blah', 2])

    UserInterface.stubs('two_way_prompt').returns(false)

    assert_equal [4, { 'blah' => 2 }], Init.custom_game_init
  end

  def test_place_ships
    init = Init.new(mock, mock)
    init.stubs('player_place_ships')
    init.stubs('computer_place_ships')

    init.expects('player_place_ships').once
    init.expects('computer_place_ships').once

    init.place_ships
  end
end
