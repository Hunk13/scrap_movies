# Class MovieCollection
class MovieCollection
  FIELDS = %i(link title year country date genre length rating director actors).freeze
  SCRAP_FILE = 'movies.txt'

  attr_reader :genres

  def initialize(file_name = SCRAP_FILE)
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

  def filter(filter_field)
    filter_field.reduce(all) do |field, (key, value)|
      field.select do |f|
        field = f.send(key)
        if field.is_a?(Array)
          field.grep(value).any?
        else
          value === field
        end
      end
    end
  end

  def stats(field)
    all.flat_map(&field)
       .each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }
       .sort
       .each do |k, v|
      puts "In #{k} include #{v} elements"
    end
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
