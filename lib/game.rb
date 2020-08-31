# frozen_string_literal: true

require './lib/player'
require './lib/computer'
require './lib/turn'

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
    game_loop
  end

  def game_setup
    print "Do you want to play with a custom board and custom ships? (y/n)\n> "
    input = gets.chomp.upcase

    until %w[Y N].include?(input)
      print "Please enter a valid input:\n> "
      input = gets.chomp.upcase
    end

    custom_game_init if input == 'Y'

    @player = Player.new(@ships, @board_size)
    @computer = Computer.new(@ships, @board_size)

    @computer.place_ships
    player_place_ships
  end

  def player_place_ships
    puts 'I have laid out my ships on the grid.'
    puts "You now need to lay out your #{@ships.length} ships"
    puts "The #{@ships.map.with_index do |ship, idx|
                  "#{ship[0]} is #{ship[1]} units long#{', and the ' if @ships.length > (idx + 1)}"
                end.join}."

    @player.ships.each do |ship|
      puts @player.board.render(true)
      print "Enter the squares for the #{ship.name} (#{ship.length} spaces):\n> "
      coordinates = gets.chomp.upcase.split(' ')
      until @player.place_ship(ship, coordinates)
        print "Those are invalid coordinates. Please try again:\n> "
        coordinates = gets.chomp.upcase.split(' ')
      end
    end
  end

  def custom_game_init
    print "What board size would you like to use?\n> "
    board_size = gets.chomp.to_i

    until board_size.positive?
      print "Please enter a valid size:\n> "
      board_size = gets.chomp.to_i
    end

    @board_size = board_size

    puts 'You may now create a new ship.'
    @ships.clear
    loop do
      print "What should this ship be called?\n> "
      ship_name = gets.chomp.capitalize

      print "How long should the #{ship_name} be?\n> "
      ship_length = gets.chomp.to_i

      until ship_length.positive? && ship_length <= @board_size
        until ship_length.positive?
          print "Please enter a valid size:\n> "
          ship_length = gets.chomp.to_i
        end

        until ship_length <= @board_size
          print "Ship length too large. Please enter a valid size:\n> "
          ship_length = gets.chomp.to_i
        end
      end

      @ships[ship_name] = ship_length

      print "Do you want to add another ship? (y/n)\n> "
      input = gets.chomp.upcase

      until %w[Y N].include?(input)
        print "Please enter a valid input:\n> "
        input = gets.chomp.upcase
      end

      break if input == 'N'
    end
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
