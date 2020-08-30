# frozen_string_literal: true

require './lib/game'

# Main menu class
class MainMenu
  def run
    loop do
      print "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.\n> "
      input = gets.chomp.upcase

      until %w[P Q].include?(input)
        print "Please enter a valid input:\n> "
        input = gets.chomp.upcase
      end
      if input == 'P'
        Game.new.play_game
      else
        break
      end
    end
    puts 'Goodbye!'
  end
end
