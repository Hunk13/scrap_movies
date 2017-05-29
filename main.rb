# second lesson
scrap_file = 'movies.txt'
search_text = 'Max'

abort('Need only one parameter - file name.') if ARGV.length > 1

file = ARGV[0] || scrap_file
abort("File '#{ARGV[0]}' not exist.") unless File.exist?(file)

File.open(file).each_line do |line|
  split_line = line.split('|')
  puts split_line[1] + ' | ' + ('*' * (split_line[7].to_f * 10 - 80).to_i) if split_line[1].include? search_text
end

# output
#
# Mad Max: Fury Road | ****
# Mary and Max | **
