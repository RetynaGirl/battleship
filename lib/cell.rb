# frozen_string_literal: true

require './lib/ship'

# Acts as a cell in the board
class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @ship.hit unless empty?

    @fired_upon = true
  end

  def render(show_ship = false)
    return 'S' if !fired_upon? && show_ship && !empty?
    return '.' unless fired_upon?
    return 'M' if fired_upon? && empty?
    return 'X' if fired_upon? && @ship.sunk?
    return 'H' if fired_upon? && !empty?
  end
end
