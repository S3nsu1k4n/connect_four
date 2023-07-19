# frozen_string_literal: true

require './lib/player'
require './lib/board'

player1 = Player.new('O')
player2 = Player.new('X')
board = Board.new

board.show_board
winner = board.evaluate

until winner
  board.put_token player1.choose_column, player1.token
  board.show_board
  break if board.evaluate

  board.put_token player2.choose_column, player2.token
  board.show_board
  winner = board.evaluate
end
