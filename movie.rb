require 'CSV'
require 'date'

class Movie
  attr_reader :link, :title, :year, :country, :date,
              :genre, :length, :rating, :director, :actors

  def initialize(movie, movie_collection = nil)
    @link     = movie[0]
    @title    = movie[1]
    @year     = movie[2].to_i
    @country  = movie[3]
    @date     = movie[4]
    @genre    = movie[5].split(',')
    @length   = movie[6].to_i
    @rating   = movie[7].to_f.round(2)
    @director = movie[8]
    @actors   = movie[9].split(',')
    @movie_collection = movie_collection
  end

  def self.build(movie, movie_collection = nil)
    case movie[2].to_i
    when 1900...1945
      AncientMovie.new(movie, movie_collection)
    when 1945...1968
      ClassicMovie.new(movie, movie_collection)
    when 1968...2000
      ModernMovie.new(movie, movie_collection)
    else
      NewMovie.new(movie, movie_collection)
    end
  end

  def matches_filter?(key, value)
    attr = Array(send(key))
    Array(value).product(attr).any? do |filter_val, attr_val|
      filter_val === attr_val
    end
  end

  def genre?(genre)
    raise("Genre '#{genre}' not found in movies genres") unless @movie_collection.genre_exists?(genre)
    @genre.include?(genre)
  end

  def to_s
    "#{@title} (#{@date}; #{@genre}) - #{@length} min; Rating: #{@rating}"
  end
end
