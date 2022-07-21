# frozen_string_literal: true

# module containing messages to display in-game
module Display
  def welcome
    <<-WELCOME
    ---------- HANGMAN ----------

    Welcome to Hangman! Your objective is to guess the secret word based on the character placeholders shown on screen.

    The catch is, you can only guess one letter at a time and you're allowed 6 incorrect guesses before you lose.

    GLHF. Press any key to play, or 'q' to quit.

    -----------------------------

    WELCOME
  end

  def show_guess(guess, good, bad)
    puts "\n\n\n"
    print 'WORD | '
    guess.each { |letter| print "#{letter} " }
    print "\n\n"
    print 'GOOD | '
    good.each { |letter| print "#{letter} " }
    print "\n\n"
    print 'BAD  | '
    bad.each { |letter| print "#{letter} " }
    print "\n\n"
  end
end
