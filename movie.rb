# Class Movie. For object Movie
class Movie
  attr_reader :link, :title, :year, :country, :date,
              :genre, :length, :rating, :director, :actors

  def initialize(movie_collection, movie)
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

  def self.create_movies(movie_collection, movie)
    case movie[2].to_i
    when 1900...1945
      AncientMovie.new(movie_collection, movie)
    when 1945...1968
      ClassicMovie.new(movie_collection, movie)
    when 1968...2000
      ModernMovie.new(movie_collection, movie)
    else
      NewMovie.new(movie_collection, movie)
    end
  end

  def matches?(params)
    params.reduce(true) do |res, (key, value)|
      res && matches_filter?(key, value)
    end
  end

  def matches_filter?(key, value)
    if send(key).is_a?(Array)
      if value.is_a?(Array)
        send(key).any? { |v| value.include?(v) }
      else
        send(key).any? { |v| v == value }
      end
    else
      value === send(key)
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
