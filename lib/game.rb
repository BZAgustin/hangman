# frozen_string_literal: true

require_relative 'display'
require_relative 'txt_parser'
require_relative 'game_logic'

# includes all necessary modules to play the game
class Game
  attr_reader :correct, :incorrect, :attempts, :word, :guess

  include TxtParser
  include Display
  include GameLogic

  def initialize
    @correct = []
    @incorrect = []
    @attempts = 6
  end

  def play
    puts welcome
    return unless player_continue?

    set_word
    player_turns
    game_over(guess, word)
  end

  def set_word
    @word = select_random_word.upcase.split(//)[0..-2]
    @guess = Array.new(word.length, '_')
  end

  def player_continue?
    input = gets.chomp.downcase

    input != 'q'
  end

  def select_random_word
    read_filtered_list.sample
  end

  def read_player_letter
    print 'Enter a letter: '
    input = gets.chomp
    return input.upcase if valid?(input)

    puts 'Invalid input! Must be a single letter'
    read_player_letter
  end

  def player_turns
    while attempts.positive?
      show_guess(guess, correct, incorrect)
      show_attempts
      letter = read_player_letter
      if letter_present?(letter, word) && !letter_present?(letter, correct)
        @guess = update_guess(letter, word, guess)
        @correct.push(letter)
        break if word_complete?(guess, word)
      elsif !letter_present?(letter, word) && !letter_present?(letter, incorrect)
        update_incorrect(letter)
      else
        puts 'You already picked this letter!'
      end
    end
  end

  def update_incorrect(letter)
    @incorrect.push(letter)
    @attempts -= 1
  end

  def show_attempts
    puts "LIVES | #{attempts}\n\n\n"
  end

  def game_over(guess, word)
    if guess == word
      puts "You win! The word was #{word.join.upcase}"
    else
      puts "You lose! The word was #{word.join.upcase}"
    end
    puts 'Do you want to play again? (Press any key to play again, or type \'q\' to quit)'
    play_again?
  end

  def play_again?
    input = gets.chomp

    Game.new.play if input.downcase != 'q'
  end
end
