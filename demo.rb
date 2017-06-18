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

movies = MovieCollection.new
puts 'All movies (cropped to 5 first)'
puts movies.all.first(5)
puts ''
puts 'Price of first movie'
puts movies.all.first.movie_price
puts ''
puts 'Movies sort by field (cropped to 5 first)'
puts movies.sort_by(:genre).first(5)
puts ''
puts 'Movies filter by field (cropped to 5 first)'
puts movies.filter(genre: 'Comedy').first(5)
puts ''
puts 'Movies statistics by field'
movies.stats(:country)
puts ''
puts 'First movie'
puts movies.all.first
puts ''
puts 'Has first movie genre Crime?'
puts movies.all.first.genre?('Crime')
puts ''
puts 'Has first movie genre Action?'
puts movies.all.first.genre?('Action')
puts ''
puts 'Has first movie genre Criminalis (not exist)?'
begin
  movies.all.first.genre?('Criminalis')
rescue RuntimeError => e
  puts e
end
puts ''
puts 'Return array of field?'
puts movies.all.first.actors
