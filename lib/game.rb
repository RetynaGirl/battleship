# frozen_string_literal: true

# Runs the game with a player and a computer
class Game
  def initialize
    @player = nil
    @computer = nil
    @board_size = 4
    @ships = { 'Cruiser' => 3, 'Submarine' => 2 }
  end

  def play_game
    game_setup
  end

  def game_setup
    p 'Do you want to play with a custom board and custom ships? (y/n)'
    input = gets.chomp.upcase

    until %w[Y N].include?(input)
      p 'Please enter a valid input:'
      input = gets.chomp.upcase
    end

    custom_game_init if input == 'Y'

    @player = Player.new(ships, board_size)
    @computer = Computer.new(ships, board_size)

    @computer.place_ships
    player_place_ships
  end
end
