# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/main_menu'

class MainMenuTest < Minitest::Test
  def test_it_exists
    menu = MainMenu.new

    assert_instance_of MainMenu, menu
  end
end