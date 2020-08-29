# frozen_string_literal: true


# Turn class
class Turn
  attr_reader :player, :computer
  def initialize(player, computer)
    @player = player
    @computer = computer
  end

  def display_boards
    @player.board.render(true)
    @computer.board.render
  end

  def player_shot_prompt
    p 'Enter the coordinate for your shot:'
    coordinate = gets.chomp.upcase

    until @player.board.valid_coordinate?(coordinate)
      p 'Please enter a valid coordinate:'
      coordinate = gets.chomp.upcase
    end
    coordinate
  end
end
