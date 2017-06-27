require 'CSV'
require 'date'
require 'pry'
require 'rspec'
require 'awesome_print'
require_relative 'movie'
require_relative 'classic_movie'
require_relative 'modern_movie'
require_relative 'ancient_movie'
require_relative 'new_movie'
require_relative 'movie_collection'
require_relative 'netflix'
require_relative 'theatre'

# movie_array_data = ['http://imdb.com/title/tt0111161/?ref_=chttp_tt_1',
#                     'The Shawshank Redemption',
#                     '1994',
#                     'USA',
#                     '1994-10-14',
#                     'Crime,Drama',
#                     '142 min',
#                     '9.3',
#                     'Frank Darabont',
#                     'Tim Robbins,Morgan Freeman,Bob Gunton']
# md = Movie.movie_data(movie_array_data)
# ap md

# movie_theatre = Theatre.new('movies.txt')
# puts ''
# puts 'When movie'
# puts movie_theatre.when?('The Godfather')
# puts ''
# puts 'When movie not exist'
# puts movie_theatre.when?('The Matrix')

# movie_netflix = Netflix.new('movies.txt')
# puts ''
# puts 'Error if not enough money'
# begin
#   puts movie_netflix.show(genre: 'Action')
# rescue RuntimeError => e
#   puts e
# end
# puts ''
# puts 'How much one movie'
# puts movie_netflix.how_much?('The Terminator')
# begin
#   puts movie_netflix.how_much?(title: 'The Terminators')
# rescue RuntimeError => e
#   puts e
# end
# movie_netflix.pay(5)
# puts ''
# puts 'Show one movie, money is enough'
# puts movie_netflix.show(title: 'The Terminator')
# begin
#   puts movie_netflix.show(title: 'The Terminator')
#   puts movie_netflix.show(title: 's')
# rescue RuntimeError => e
#   puts e
# end
# puts ''
# puts 'How much money after show movie'
# puts movie_netflix.money

movies = MovieCollection.new
# puts ''
# puts 'All movies (cropped to 5 first)'
# ap movies.all.first.class
# puts ''
# puts 'Price of first movie'
# puts movies.all.first.movie_price
# puts ''
# puts 'Movies sort by field (cropped to 5 first)'
# puts movies.sort_by(:genre).first(5)
puts ''
puts 'Movies filter by field'
puts movies.filter(director: 'Frank Darabont')[0]
# puts ''
# puts 'Movies statistics by field'
# movies.stats_puts(movies.stats(:country))
# puts ''
# puts 'First movie'
# puts movies.all.first
# puts ''
# puts 'Has first movie genre Crime?'
# puts movies.all.first.genre?('Crime')
# puts ''
# puts 'Has first movie genre Action?'
# puts movies.all.first.genre?('Action')
# puts ''
# puts 'Has first movie genre Criminalis (not exist)?'
# begin
#   movies.all.first.genre?('Criminalis')
# rescue RuntimeError => e
#   puts e
# end
# puts ''
# puts 'Return array of field?'
# puts movies.all.first.actors
