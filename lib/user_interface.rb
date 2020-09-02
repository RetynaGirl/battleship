# frozen_string_literal: true

# Defines methods that interact with the player
class UserInterface
  def self.custom_ship_input(board_size)
    print "What should this ship be called?\n> "
    ship_name = gets.chomp.capitalize

    print "How long should the #{ship_name} be?\n> "
    ship_length = gets.chomp.to_i

    until ship_length.positive? && ship_length <= board_size

      print "Please enter a valid size:\n> "
      ship_length = gets.chomp.to_i

    end

    [ship_name, ship_length]
  end

  def self.output(string)
    puts string
  end

  def self.two_way_prompt(prompt, options)
    print prompt
    input = gets.chomp.upcase

    until options.include?(input)
      print "Please enter a valid input:\n> "
      input = gets.chomp.upcase
    end
    input == options.first
  end

  def place_ship(ship, board)
    puts board.render(true)
    print "Enter the squares for the #{ship.name} (#{ship.length} spaces):\n> "
    coordinates = gets.chomp.upcase.split(' ')
    until board.valid_placement?(ship, coordinates)
      print "Those are invalid coordinates. Please try again:\n> "
      coordinates = gets.chomp.upcase.split(' ')
    end
    coordinates
  end

  def shot_position(other_board, shots)
    print "Enter the coordinate for your shot:\n> "
    coordinate = gets.chomp.upcase

    while shots.include?(coordinate) || !other_board.valid_coordinate?(coordinate)

      until other_board.valid_coordinate?(coordinate)
        print "Please enter a valid coordinate:\n> "
        coordinate = gets.chomp.upcase
      end

      while shots.include?(coordinate)
        print "You already fired at this position. Please choose a new coordinate:\n> "
        coordinate = gets.chomp.upcase
      end
    end
    coordinate
  end
end
