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

    assert_equal 2, player.generate_player_ships.length
  end

  def test_player_places_ship
    player1 = Player.new
    ship1 = Ship.new('Cruiser', 3)

    player1.player_place_ship(ship1, %w[A1 A2 A3])

    actual1 = player1.player.cells['A1'].ship
    actual2 = player1.player.cells['A1'].ship
    actual3 = player1.player.cells['A1'].ship

    assert_equal ship1, actual1
    assert_equal ship1, actual2
    assert_equal ship1, actual3
  end
end
