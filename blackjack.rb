require 'pry'
require 'colorize'
Dir.glob('./lib/*', &method(:require))

game = Game.new
game.start
game.blackjack_check
game.summarize
game.player_move
game.player_bust_check
game.dealer_move
game.dealer_bust_check
game.show_game_result
game.exit_game