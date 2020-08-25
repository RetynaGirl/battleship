# frozen_string_literal: true

require './lib/ship'

# Acts as a cell in the board
class Cell
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end
end