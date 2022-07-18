# frozen_string_literal: true

# game logic
module GameLogic
  def letter_present?(letter, word)
    word.include?(letter)
  end

  def valid?(input)
    input.length == 1 && input !=~ /\w\D/ && input != ''
  end

  def word_complete?(guess, word)
    guess == word
  end
end
