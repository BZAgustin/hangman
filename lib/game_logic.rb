# frozen_string_literal: true

# game logic
module GameLogic
  def letter_present?(letter, word)
    word.include?(letter)
  end

  def valid?(input)
    input.length == 1 && input.match(/[a-zA-Z]/) && input != ''
  end

  def word_complete?(guess, word)
    guess == word
  end

  def update_guess(letter, word, guess)
    word.each_index { |index| guess[index] = letter if word[index] == letter }
    guess
  end
end
