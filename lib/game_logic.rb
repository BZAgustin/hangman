# frozen_string_literal: true

# game logic
module GameLogic
  # determines if input on player_turns is an alphabetical letter or a command
  def valid_input?(input)
    (input.length == 1 && input.match(/[a-zA-Z]/)) || %w[save quit].include?(input.downcase)
  end

  # determines if input is a single-digit number
  def valid_save?(input)
    input.length == 1 && input.match(/\d/)
  end

  # self-explanatory
  def word_complete?(guess, word)
    guess == word
  end

  # fill the correspondent placeholder(s) with the letter provided
  def update_guess(letter, word, guess)
    word.each_index { |index| guess[index] = letter if word[index] == letter }
    guess
  end
end
