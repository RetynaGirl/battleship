# frozen_string_literal: true

require './lib/ship'

# Acts as a cell in the board
class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def empty?
    return @ship.nil?
  end
end
