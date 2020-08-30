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
    game_loop
  end

  def game_setup
    p 'Do you want to play with a custom board and custom ships? (y/n)'
    input = gets.chomp.upcase

    until %w[Y N].include?(input)
      p 'Please enter a valid input:'
      input = gets.chomp.upcase
    end

    custom_game_init if input == 'Y'

    @player = Player.new(@ships, @board_size)
    @computer = Computer.new(@ships, @board_size)

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

  def custom_game_init
    p "What board size would you like to use?\n> "
    @board_size = gets.chomp.to_i

    @ships.clear
    loop do
      p "What should this ship be called?\n> "
      ship_name = gets.chomp.capitalize

      p "How long should the #{ship_name} be?\n> "
      ship_length = gets.chomp.to_i

      until ship_length.positive?
        p 'Please enter a valid size:'
        ship_length = gets.chomp.to_i
      end

      @ships[ship_name] = ship_length

      p "Do you want to add another ship? (y/n)\n> "
      input = gets.chomp.upcase

      until %w[Y N].include?(input)
        p 'Please enter a valid input:'
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
      p 'Wow! We tied!'
    elsif @player.lost?
      p 'I won!'
    else
      p 'You won!'
    end
  end
end
