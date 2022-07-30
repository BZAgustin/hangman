# frozen_string_literal: true

# read and filter the text file
module TxtParser
  # open words.txt and remove every word less than 6 characters and more than 12 characters long
  def read_filtered_list
    words = File.open('./words.txt')

    words.reject { |line| line.length < 6 || line.length > 13 }
  end

  def select_random_word
    read_filtered_list.sample
  end
end
