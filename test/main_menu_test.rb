# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class MainMenu < Minitest::Test
  def test_it_exists
    menu = MainMenu.new

    assert_instance_of MainMenu, menu
  end
end