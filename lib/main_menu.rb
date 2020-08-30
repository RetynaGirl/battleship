# frozen_string_literal: true

require './lib/game'

# Main menu class
class MainMenu
  def run
    loop do
      p "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.\n> "
      input = gets.chomp.upcase

      until %w[P Q].include?(input)
        p 'Please enter a valid input:'
        input = gets.chomp.upcase
      end
      if input == 'P'
        Game.new.play_game
      else
        break
      end
    end
    p 'Goodbye!'
  end
end
