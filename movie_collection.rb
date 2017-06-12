require 'CSV'
require 'date'

# Class MovieCollection
class MovieCollection
  FIELDS = %i(link title year country date genre length rating director actors).freeze
  SCRAP_FILE = 'movies.txt'

  attr_reader :genres

  def initialize(file_name)
    abort("File #{file_name} not exist.") unless File.file?(file_name)
    @movies = parse_file(file_name)
    @genres = @movies.flat_map(&:genre).uniq
  end

  def all
    @movies
  end

  def sort_by(sort_field)
    @movies.sort_by(&sort_field)
  end

  def filter(field)

  end

  def stats(field)

  end

  def genre_exists?(genre)
    @genres ||= @movies.collect(&:genre)
    genres.include?(genre)
  end

  private

  def parse_file(file_name)
    CSV.foreach(file_name, col_sep: '|', headers: FIELDS).map {
      |movie| Movie.new(self, movie)
    }
  end
end
