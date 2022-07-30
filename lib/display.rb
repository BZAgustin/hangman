# frozen_string_literal: true

# module containing messages to display in-game
module Display
  # first message that appears when running the program
  def welcome
    <<-WELCOME
    ---------- HANGMAN ----------

    Welcome to Hangman! Your objective is to guess the secret word based on the character placeholders shown on screen.

    The catch is, you can only guess one letter at a time and you're allowed 6 incorrect guesses before you lose.

    GLHF.

    -----------------------------

    WELCOME
  end

  # different prompts based on whether 'saves' folder has files or not
  def new_game_message
    if Dir.empty?('saves')
      puts '# Press Enter or type anything to play. Type \'q\' to quit'
    else
      puts '# Press Enter or type anything to play'
      puts '# Type \'load\' to load a previous game'
      puts "# Type 'q' to quit\n\n"
    end
  end

  # displays list of available saves
  def show_saves
    count = 1
    Dir.foreach('saves') do |filename|
      unless %w[. ..].include?(filename)
        puts "#{count} - #{filename}"
        count += 1
      end
    end
  end

  # displays current word state, good and bad guesses, and attempts left
  def show_guess(guess, good, bad, attempts)
    print "\n\n\nWORD | "
    guess.each { |letter| print "#{letter} " }
    print "\n\nGOOD | "
    good.each { |letter| print "#{letter} " }
    print "\n\nBAD  | "
    bad.each { |letter| print "#{letter} " }
    print "\n\nLIVES | #{attempts}\n\n\n"
  end
end
