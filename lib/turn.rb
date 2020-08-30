# frozen_string_literal: true

# Turn class
class Turn
  attr_reader :player, :computer
  def initialize(player, computer)
    @player = player
    @computer = computer
    @computer_shot = nil
    @player_shot = nil
  end

  def display_boards
    @player.board.render(true)
    @computer.board.render
  end

  def player_shot_prompt
    p 'Enter the coordinate for your shot:'
    coordinate = gets.chomp.upcase

    while @player.shots.include?(coordinate) || !@computer.board.valid_coordinate?(coordinate)

      until @computer.board.valid_coordinate?(coordinate)
        p 'Please enter a valid coordinate:'
        coordinate = gets.chomp.upcase
      end

      while @player.shots.include?(coordinate)
        p 'You already fired at this position.'
        coordinate = gets.chomp.upcase
      end
    end
    coordinate
  end

  def player_shoot
    coordinate = player_shot_prompt
    @player_shot = coordinate

    @player.shots << coordinate
    @computer.board.cells[coordinate].fire_upon
  end

  def computer_shoot
    coordinate = @computer.shot_position
    @computer_shot = coordinate

    @computer.shots << coordinate
    @player.board.cells[coordinate].fire_upon
  end

  def print_results
    if @computer.board.cells[@player_shot].empty?
      p "Your shot on #{@player_shot} was a miss."
    elsif @computer.board.cells[@player_shot].ship.sunk?
      p "Your shot on #{@player_shot} was a hit and sunk my #{@computer.board.cells[@player_shot].ship.name}."
    else
      p "Your shot on #{@player_shot} was a hit."
    end

    if @player.board.cells[@computer_shot].empty?
      p "My shot on #{@computer_shot} was a miss."
    elsif @player.board.cells[@computer_shot].ship.sunk?
      p "My shot on #{@computer_shot} was a hit and sunk your #{@player.board.cells[@computer_shot].ship.name}."
    else
      p "My shot on #{@computer_shot} was a hit."
    end
  end
end
