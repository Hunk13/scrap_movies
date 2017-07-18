# frozen_string_literal: true

require 'csv'
require 'date'
require 'pry'
require 'rspec'
require 'awesome_print'
require 'colorize'

require_relative 'lib/scrap_movies'

movie_array_data = ['http://imdb.com/title/tt0111161/?ref_=chttp_tt_1',
                    'The Shawshank Redemption',
                    '1994',
                    'USA',
                    '1994-10-14',
                    'Crime,Drama',
                    '142 min',
                    '9.3',
                    'Frank Darabont',
                    'Tim Robbins,Morgan Freeman,Bob Gunton']
md = ScrapMovies::Movie.build(movie_array_data)
ap md

puts '================ test Theatre Class =================='
movie_theatre = ScrapMovies::Theatre.new('movies.txt')
puts ''
puts 'When showing movie "The Godfather"'.green
puts movie_theatre.when?('The Godfather')
puts ''
puts 'When movie "The Matrixxxx" not exist'.green
begin
  movie_theatre.when?('The Matrixxxx')
rescue ArgumentError => e
  puts e
end
puts ''
puts 'Show movie in morning'.green
puts movie_theatre.show('Morning')
puts ''
puts 'Show movie in nigth'.green
begin
  movie_theatre.show('Night')
rescue RuntimeError => e
  puts e
end
puts ''
puts 'Buy one ticket'.green
puts movie_theatre.buy_ticket('20:00')

puts '================ test Netflix Class =================='
movie_netflix = ScrapMovies::Netflix.new('movies.txt')
puts ''
puts 'Error if not enough money'.green
begin
  movie_netflix.show(genre: 'Action')
rescue RuntimeError => e
  puts e
end
puts ''
puts 'How much one movie'.green
puts movie_netflix.how_much?('The Terminator')
puts ''
puts 'How much one movie when movie not exist'.green
begin
  movie_netflix.how_much?('The Terminators')
rescue ArgumentError => e
  puts e
end
movie_netflix.pay(5)
puts ''
puts 'Show one movie, money is enough'.green
puts movie_netflix.show(title: 'The Terminator')
puts ''
puts 'Show two movies, after first money is not enough'.green
begin
  puts movie_netflix.show(title: 'The Terminator')
  puts movie_netflix.show(title: 's')
rescue RuntimeError => e
  puts e
end
puts ''
puts 'How much money after show movie'.green
puts movie_netflix.money
puts 'How much is in cashbox?'.green
puts ScrapMovies::Netflix.cash
puts 'Get money from bank'.green
puts ScrapMovies::Netflix.take('Bank')
puts 'Get money to Criminal'.green
begin
  puts ScrapMovies::Netflix.take('Criminal')
rescue ScrapMovies::CashDesk::Unauthorized => e
  puts e
end

puts '================ test MovieCollection Class =================='
movies = ScrapMovies::MovieCollection.new('movies.txt')
one_movie = movies.all.first
puts ''
puts 'First movie class'.green
ap one_movie.class
puts ''
puts 'Price of first movie'.green
puts one_movie.movie_price
puts ''
puts 'Movies sort by field (cropped to 5 first)'.green
puts movies.sort_by(:genre).first(5)
puts ''
puts 'Movies filter by field'.green
puts movies.filter(director: 'Frank Darabont')
puts ''
puts 'Movies filter by empty field'.green
puts movies.filter(director: '')
puts ''
puts 'Movies statistics by field'.green
puts movies.stats(:director)
puts ''
puts 'First movie'.green
puts one_movie
puts ''
puts 'Has first movie genre Crime?'.green
puts one_movie.genre?('Crime')
puts ''
puts 'Has first movie genre Action?'.green
puts one_movie.genre?('Action')
puts ''
puts 'Has first movie genre Criminalis (not exist)?'.green
begin
  one_movie.genre?('Criminalis')
rescue RuntimeError => e
  puts e
end
puts ''
puts 'Return array of field'.green
puts one_movie.actors

movies.map do |m|
  puts m
end
