# frozen_string_literal: true

# Holds methods that initialize the game
class Init
  attr_reader :player, :computer

  def initialize(player, computer)
    @player = player
    @computer = computer
  end

  def player_place_ships
    UserInterface.output "I have laid out my ships on the grid.
      \nYou now need to lay out your #{@player.ships.length} ships.
      \nThe #{@player.ships.map.with_index do |ship, idx|
                "#{ship.name} is #{ship.length} units long#{
                                        ', the ' if @player.ships.length > (idx + 2)
                                      }#{
                                        ', and the ' if @player.ships.length == (idx + 2)
                                      }"
              end.join}."

    @player.ships.each do |ship|
      coordinates = @player.interface.place_ship(ship, @player.board)
      @player.place_ship(ship, coordinates)
    end
  end

  def computer_place_ships
    @computer.ships.each do |ship|
      coordinates = @computer.interface.place_ship(ship, @computer.board)
      coordinates = @computer.interface.place_ship(ship, @computer.board) until @computer.place_ship(ship, coordinates)
    end
  end

  def self.custom_board_size
    print "What board size would you like to use?\n> "
    board_size = gets.chomp.to_i

    until board_size.positive?
      print "Please enter a valid size:\n> "
      board_size = gets.chomp.to_i
    end

    board_size
  end

  def self.custom_ship(ships, board_size)
    ship_data = UserInterface.custom_ship_input(board_size)

    ships[ship_data[0]] = ship_data[1]
    ships
  end

  def self.custom_game_init
    board_size = custom_board_size

    UserInterface.output 'You may now create a new ship.'
    ships = {}
    loop do
      custom_ship(ships, board_size)
      break unless UserInterface.two_way_prompt("Do you want to add another ship? (y/n)\n> ", %w[Y N])
    end
    [board_size, ships]
  end

  def place_ships
    player_place_ships
    computer_place_ships
  end
end
