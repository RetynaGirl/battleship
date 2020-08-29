# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/player'


class PlayerTest < Minitest::Test
  def test_it_exists
    player = Player.new

    assert_instance_of Player, player
  end

  def test_player_generates_ships
    player = Player.new

    assert_equal 2, player.ships.length
  end

  def test_player_places_ship
    player = Player.new
    ship1 = Ship.new('Cruiser', 3)

    player.player_place_ship(ship1, %w[A1 A2 A3])

    actual1 = player.board.cells['A1'].ship
    actual2 = player.board.cells['A2'].ship
    actual3 = player.board.cells['A3'].ship

    assert_equal ship1, actual1
    assert_equal ship1, actual2
    assert_equal ship1, actual3
  end

  def test_valid_sequence?
    player = Player.new
    ship1 = Ship.new('Cruiser', 3)
    ship2 = Ship.new('Cruiser', 3)

    assert_equal true, player.valid_sequence?(ship1, %w[A1 A2 A3])
    assert_equal false, player.valid_sequence?(ship2, %w[A3 A1 A2])
  end

  def test_player_lost
    player = Player.new

    assert_equal false, player.lost?

    player.ships[0].hit
    player.ships[0].hit

    assert_equal false, player.lost?

    player.ships[1].hit
    player.ships[1].hit
    player.ships[1].hit

    assert_equal true, player.lost?
  end
end
