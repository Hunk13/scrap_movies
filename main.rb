# second lesson
file = 'movies.txt'
search_text = 'Max'

abort('Need only one parameter - file name.') if ARGV.length > 1

if File.exist?(file)
  file if ARGV[0] == file || nil?
elsif ARGV[0] && File.exist?(ARGV[0])
  file = ARGV[0]
else
  ARGV[0] ? abort("File '#{ARGV[0]}' not exist.") : abort('No files to scrap')
end

File.open(file).each_line do |line|
  split_line = line.split('|')
  puts split_line[1] + ' | ' + ('*' * (split_line[7].to_f * 10 - 80).to_i) if split_line[1].include? search_text
end

# output
#
# Mad Max: Fury Road | ****
# Mary and Max | **
