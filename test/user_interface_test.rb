# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/player'
require './lib/user_interface'
require 'mocha/minitest'

class UserInterfaceTest < Minitest::Test
  def test_it_exists
    ui = UserInterface.new

    assert_instance_of UserInterface, ui
  end
end
