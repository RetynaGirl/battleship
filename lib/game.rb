# frozen_string_literal: true

require './lib/player'
require './lib/computer'
require './lib/turn'
require './lib/user_interface'
require './lib/init'

# Runs the game with a player and a computer
class Game
  attr_accessor :player, :computer

  def initialize
    @player = nil
    @computer = nil
    @board_size = 4
    @ships = { 'Cruiser' => 3, 'Submarine' => 2 }
  end

  def play_game
    game_setup
    game_loop
  end

  def game_setup
    @board_size, @ships = Init.custom_game_init if UserInterface.two_way_prompt(
      "Do you want to play with a custom board and custom ships? (y/n)\n> ",
      %w[Y N]
    )

    @player = Player.new(@ships, @board_size, UserInterface.new)
    @computer = Player.new(@ships, @board_size, Computer.new)

    init = Init.new(@player, @computer)

    init.place_ships
  end

  def game_loop
    loop do
      turn = Turn.new(@player, @computer)

      turn.display_boards

      turn.player_shoot
      turn.computer_shoot

      turn.print_results

      break if @player.lost? || @computer.lost?
    end

    display_winner
  end

  def display_winner
    if @player.lost? && @computer.lost?
      puts 'Wow! We tied!'
    elsif @player.lost?
      puts 'I won!'
    else
      puts 'You won!'
    end
  end
end
