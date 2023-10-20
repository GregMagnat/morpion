require 'bundler'
Bundler.require

require_relative "lib/board.rb"
require_relative "lib/game.rb"
require_relative "lib/player.rb"

game = Game.new
game.start_game

binding.pry