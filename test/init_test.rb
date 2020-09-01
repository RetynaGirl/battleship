# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/player'
require './lib/computer'
require './lib/init'

class InitTest < Minitest::Test
  def test_it_exists
    init = Init.new

    assert_instance_of Init, init
  end
end
