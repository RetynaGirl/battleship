# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/player'
require './lib/user_interface'
require 'mocha/minitest'

class PlayerTest < Minitest::Test
  def test_it_exists
    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, UserInterface)

    assert_instance_of Player, player
  end

  def test_player_generates_ships
    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, UserInterface)

    assert_equal 2, player.ships.length
  end

  def test_player_places_ship
    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, UserInterface)
    ship1 = Ship.new('Cruiser', 3)

    player.place_ship(ship1, %w[A1 A2 A3])

    actual1 = player.board.cells['A1'].ship
    actual2 = player.board.cells['A2'].ship
    actual3 = player.board.cells['A3'].ship

    assert_equal ship1, actual1
    assert_equal ship1, actual2
    assert_equal ship1, actual3
  end

  def test_ship_placement_coords
    mock_interface = mock
    mock_interface.stubs('place_ship').returns(%w[A1 A2])

    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, mock_interface)

    assert_equal %w[A1 A2], player.ship_placement_coords
  end

  def test_player_lost
    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, UserInterface)

    assert_equal false, player.lost?

    player.ships[0].hit
    player.ships[0].hit

    assert_equal false, player.lost?

    player.ships[1].hit
    player.ships[1].hit
    player.ships[1].hit

    assert_equal true, player.lost?
  end

  def test_shot_coordinate
    board = Board.new(2)
    mock_interface = mock
    mock_interface.stubs('shot_position').returns('A1')

    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, mock_interface)

    assert_equal 'A1', player.shot_coordinate(board)
  end

  def test_fire_upon
    player = Player.new({ 'Submarine' => 2, 'Cruiser' => 3 }, 4, UserInterface)

    player.fire_upon('A1')

    assert player.board.cells['A1'].fired_upon?
  end
end
