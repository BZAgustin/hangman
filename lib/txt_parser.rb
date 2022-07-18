# frozen_string_literal: true

# read and filter the text file
module TxtParser
  def read_filtered_list
    words = File.open('./words.txt')

    words.reject { |line| line.length < 6 || line.length > 13 }
  end
end
