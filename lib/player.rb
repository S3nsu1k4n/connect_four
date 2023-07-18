# frozen_string_literal: true

# represents the player of the game
class Player
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def choose_column
    puts "Player (#{token})"
    puts 'Choose a column to place your token!'
    puts '0 - 3'
    gets[0].to_i
  end
end
