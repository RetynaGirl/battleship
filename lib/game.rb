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

  def player_place_ships
    p 'I have laid out my ships on the grid.'
    p "You now need to lay out your #{@ships.length} ships"
    p "The #{@ships.map.with_index do |ship, idx|
               "#{ship[0]} is #{ship[1]} units long#{', and the ' if @ships.length > (idx + 1)}"
             end.join}."

    @player.ships.each do |ship|
      p @player.board.render(true)
      p "Enter the squares for the #{ship.name} (#{ship.length} spaces):\n> "
      coordinates = gets.chomp.upcase.split(' ')
      until @player.place_ship(coordinates)
        p "Those are invalid coordinates. Please try again:\n> "
        coordinates = gets.chomp.upcase.split(' ')
      end
    end
  end
end
