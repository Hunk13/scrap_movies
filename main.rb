require 'CSV'
require 'ostruct'
require 'date'

scrap_file = 'movies.txt'
FIELDS = %i(link title year country date genre length raiting director actors).freeze

abort('Need only one parameter - file name.') if ARGV.length > 1
file = ARGV[0] || scrap_file
abort('File not exist.') unless File.exist?(file)

array_of_movies = CSV.foreach(file, col_sep: '|', headers: FIELDS).map {
  |line| OpenStruct.new(line.to_h)
}

def cool_print(input_hash)
  "#{input_hash[:title]} (#{input_hash[:date]}; #{input_hash[:genre]}) - #{input_hash[:length]}"
end

puts 'Show 5 first largest movies:'
array_of_movies.sort_by { |movie| -movie.length.to_i }
               .first(5).each do |movie|
  puts cool_print(movie)
end

puts ''
puts 'Show 10 first comedies from release date:'
array_of_movies.select { |movie| movie.genre.include?('Comedy') }
               .sort_by(&:date).first(10).each do |movie|
  puts cool_print(movie)
end

puts ''
puts 'Show all directors alphabetically:'
puts array_of_movies.map { |movie| movie.director.split(' ').reverse.join(' ') }.uniq.sort

puts ''
puts 'Number of films not in the USA:'
puts array_of_movies.count { |movie| movie.country != 'USA' }

puts ''
puts 'Show statistic from month:'
array_of_movies.map { |movie| Date._parse(movie.date)[:mon] }
               .each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }
               .reject { |key, _value| !key.between?(1, 12) }
               .sort
               .each do |k, v|
  puts "In #{Date::MONTHNAMES[k]} made #{v} films"
end
