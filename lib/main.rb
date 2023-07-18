# frozen_string_literal: true

require './lib/player'
require './lib/board'

player1 = Player.new('O')
player2 = Player.new('X')
board = Board.new

winner_not_determin = board.evaluate.nil?
while winner
  player1.choose_column
