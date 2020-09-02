# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/player'
require './lib/turn'
require './lib/computer'
require './lib/user_interface'
require 'mocha/minitest'

class TurnTest < Minitest::Test
  def test_it_exists
    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, UserInterface)
    computer = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, Computer)
    turn = Turn.new(player, computer)

    assert_instance_of Turn, turn
  end

  def test_player_shoot
    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, UserInterface)
    computer = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, Computer)

    player.stubs('shot_coordinate').returns('B2')

    turn = Turn.new(player, computer)

    turn.player_shoot

    assert_equal ['B2'], player.shots
    assert computer.board.cells['B2'].fired_upon?
  end

  def test_computer_shoot
    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, UserInterface)
    computer = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, Computer)

    computer.stubs('shot_coordinate').returns('B2')

    turn = Turn.new(player, computer)

    turn.computer_shoot

    assert_equal ['B2'], computer.shots
    assert player.board.cells['B2'].fired_upon?
  end
end
