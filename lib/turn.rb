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

    until @computer.board.valid_coordinate?(coordinate)
      p 'Please enter a valid coordinate:'
      coordinate = gets.chomp.upcase
    end
    coordinate
  end

  def player_shoot
    coordinate = player_shot_prompt

    @player.shots << coordinate
    @computer.board.cells[coordinate].fire_upon
  end

  def computer_shoot
    coordinate = @computer.get_shot_position

    @computer.shots << coordinate
    @player.board.cells[coordinate].fire_upon
  end
end
