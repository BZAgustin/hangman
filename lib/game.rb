# frozen_string_literal: true

require_relative 'display'
require_relative 'txt_parser'
require_relative 'game_logic'
require_relative 'io'
require 'yaml'

# includes all necessary modules to play the game
class Game
  attr_reader :correct, :incorrect, :attempts, :word, :guess

  include TxtParser
  include Display
  include GameLogic
  include Io

  def initialize(correct = [], incorrect = [], attempts = 6, word = [], guess = [])
    @correct = correct
    @incorrect = incorrect
    @attempts = attempts
    @word = word
    @guess = guess
  end

  # first method called on the program
  def play
    puts welcome
    new_game_message
    case gets.chomp.downcase
    when 'load'
      player_load
    when 'q'
      return
    else
      new_game
    end
  end

  # called when starting a new game from scratch
  def new_game
    set_word
    player_turns
    game_over(guess, word)
  end

  # called when loading a previous save
  def resume_game
    puts "\n\n----------------------------"
    puts 'Welcome back!'
    player_turns
    game_over(guess, word)
  end

  # picks a random word (5 to 12 digits) from word.txt
  def set_word
    @word = select_random_word.upcase.split(//)[0..-2]
    @guess = Array.new(word.length, '_')
  end

  # asks player for a valid letter to guess
  def read_player_letter
    print 'Enter a letter (or type \'save\' to save your progress): '
    input = gets.chomp
    return input.upcase if valid_input?(input)

    puts 'Invalid input! Must be a single letter or an exit command'
    read_player_letter
  end

  # game loop
  def player_turns
    while attempts.positive?
      show_guess(guess, correct, incorrect, attempts)
      letter = read_player_letter
      case letter.downcase
      when 'save'
        player_save
        next
      when 'quit'
        break
      else
        update(letter)
      end
      break if word_complete?(guess, word)
    end
  end

  # adds chosen letter to 'correct' or 'incorrect', or prints a message if it's been picked already
  def update(letter)
    if word.include?(letter)
      return update_correct(letter, word, guess) unless correct.include?(letter)
    else
      return update_incorrect(letter) unless incorrect.include?(letter)
    end
    puts 'You already picked this letter!'
  end

  def update_correct(letter, word, guess)
    @guess = update_guess(letter, word, guess)
    @correct.push(letter)
  end

  def update_incorrect(letter)
    @incorrect.push(letter)
    @attempts -= 1
  end

  # method reached if attempts run out, player quits or player wins
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

  # defines save name and overwrites existing saves if allowed by the player
  def player_save
    print 'Enter a name for your save: '
    save_name = gets.chomp
    unless File.exist?("saves/#{save_name}.yaml")
      return save_game(save_name, to_yaml(correct, incorrect, attempts, word, guess))
    end

    puts 'File already exists. Overwrite? (\'Y\' to overwrite or any other key to cancel)'
    overwrite = gets.chomp
    return save_game(save_name, to_yaml(correct, incorrect, attempts, word, guess)) if overwrite.downcase == 'y'

    player_save
  end

  def load_game(name)
    content = File.read(name)
    from_yaml(content)
  end

  # resumes previously saved game if user picks a valid save number
  def player_load
    show_saves
    saves = read_file_list
    choice = gets.chomp
    if valid_save?(choice)
      saves.each_pair { |key, value| load_game("saves/#{value}").resume_game if choice == key.to_s }
      return
    else
      puts 'Invalid save number. Try again'
    end
    player_load
  end

  # de-serializes string into Game object
  def from_yaml(string)
    data = YAML.load string
    Game.new(data[:correct], data[:incorrect], data[:attempts], data[:word], data[:guess])
  end
end
