require 'CSV'
require 'date'

# Class MovieCollection
class MovieCollection
  FIELDS = %i(link title year country date genre length rating director actors).freeze
  SCRAP_FILE = 'movies.txt'

  def initialize(file = SCRAP_FILE)
    @file = file
    abort("File #{@file} not exist.") unless File.exist?(@file)
    @movies = CSV.read(@file, col_sep: '|', headers: FIELDS).map {
      |movie| Movie.new(movie)
    }
  end

  def all
    @movies
  end

  def sort_by(sort_field)
    @movies.sort_by(&sort_field)
  end

  def filter(field, value)

  end

  def stats(field)

  end
end
