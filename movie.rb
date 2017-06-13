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

  def has_genre?(genre)
    raise("Genre '#{genre}' not found in movies genres") unless @movie_collection.genre_exists?(genre)
    @genre.include?(genre)
  end

  def to_s
    "#{@title} (#{@date}; #{@genre}) - #{@length} min; Rating: #{@rating}"
  end
end
