# second lesson
file = 'movies.txt'
search_text = 'Max'

if ARGV.length.zero?
  puts 'There is no input file. Take the default file.'
  file
elsif ARGV.length > 1
  abort('Need only one parameter - file name.')
elsif File.exist?(ARGV[0]) ? file = ARGV[0] : abort("File '#{ARGV[0]}' not exist.")
else
  file
end

open_file = File.open(file, 'r')
output_movies = []

open_file.each do |line|
  split_line = line.split('|')
  output_movies << split_line if split_line[1].include? search_text
end

output_movies.each do |output_movie|
  puts output_movie[1] + ' | ' + ('*' * ('%.1f' % ((output_movie[7].to_f - 8) * 10)).to_i)
end

open_file.close

# output
#
# Mad Max: Fury Road | ****
# Mary and Max | **
