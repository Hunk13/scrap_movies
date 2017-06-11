require_relative 'movie'
require_relative 'movie_collection'
require 'awesome_print'

movies = MovieCollection.new('movies.txt')
ap movies.all.first.to_s
ap movies.all.first.has_genre?('Crime')
ap movies.all.first.actors

# ap movies.all.first.to_s
# ap movies.all.first(5)
# ap movies.sort_by(:genre).first(5)
