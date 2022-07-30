# frozen_string_literal: true

# save and load functions
module Io
  # serializes Game object
  def to_yaml(corr, incorr, att, wrd, gss)
    YAML.dump({
                correct: corr,
                incorrect: incorr,
                attempts: att,
                word: wrd,
                guess: gss
              })
  end

  # writes a save file on 'saves' folder
  def save_game(name, content)
    Dir.mkdir('saves') unless Dir.exist?('saves')

    filename = "#{name}.yaml"

    File.open("saves/#{filename}", 'w') { |file| file.puts content }

    puts 'Game saved succesfully!'
  end

  # returns a hash with keys as save numbers and values as file names
  def read_file_list
    save_files = {}
    file_n = 1
    Dir.foreach('saves') do |filename|
      unless %w[. ..].include?(filename)
        save_files[file_n] = filename
        file_n += 1
      end
    end
    save_files
  end
end
