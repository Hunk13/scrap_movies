# second lesson
scrap_file = 'movies.txt'
fields = %i(link title year country date genre length raiting director actors)

abort('Need only one parameter - file name.') if ARGV.length > 1
file = ARGV[0] || scrap_file
abort('File not exist.') unless File.exist?(file)

array_of_movies = File.open(file).each_line.map do |line|
  fields.map.zip(line.strip.split('|')).to_h
end
