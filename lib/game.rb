# frozen_string_literal: true

require_relative 'display'
require_relative 'txt_parser'
require_relative 'game_logic'

# includes all necessary modules to play the game
class Game
  include TxtParser
  include Display
  include GameLogic

  def initialize
    @guess = []
    @correct = []
    @incorrect = []
    @attempts = 6
  end

  def play
    puts welcome
    return unless player_continue?

    set_word
    player_turns
  end

  def set_word
    @word = select_random_word.to_a
    @word.length times @guess.push('_')
  end

  def player_continue?
    input = gets.chomp.downcase

    input != 'q'
  end

  def select_random_word
    read_filtered_list.sample
  end

  def read_player_letter
    puts 'Enter a letter:'
    input = gets.chomp
    return input.downcase if valid?(input)

    puts 'Invalid input! Must be a single letter'
    get_player_guess
  end

  def player_turns; end

  def update_guess(letter, word)
    word.each_index { |index| @guess[index] == letter if word[index] == letter }
    @correct.push(letter)
  end
end
