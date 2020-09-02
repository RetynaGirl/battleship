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
    puts '=============COMPUTER BOARD============='
    puts @computer.board.render
    puts '==============PLAYER BOARD=============='
    puts @player.board.render(true)
  end

  def player_shoot
    coordinate = @player.shot_coordinate(@computer.board)
    @player_shot = coordinate

    @player.shots << coordinate
    @computer.fire_upon(coordinate)
  end

  def computer_shoot
    coordinate = @computer.shot_coordinate(@player.board)
    @computer_shot = coordinate

    @computer.shots << coordinate
    @player.fire_upon(coordinate)
  end

  def print_results
    if @computer.board.cells[@player_shot].empty?
      puts "Your shot on #{@player_shot} was a miss."
    elsif @computer.board.cells[@player_shot].ship.sunk?
      puts "Your shot on #{@player_shot} was a hit and sunk my #{@computer.board.cells[@player_shot].ship.name}."
    else
      puts "Your shot on #{@player_shot} was a hit."
    end

    if @player.board.cells[@computer_shot].empty?
      puts "My shot on #{@computer_shot} was a miss."
    elsif @player.board.cells[@computer_shot].ship.sunk?
      puts "My shot on #{@computer_shot} was a hit and sunk your #{@player.board.cells[@computer_shot].ship.name}."
    else
      puts "My shot on #{@computer_shot} was a hit."
    end
  end
end
