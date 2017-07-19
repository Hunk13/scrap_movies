# frozen_string_literal: true

module ScrapMovies
  class MovieCollection
    include Enumerable

    FIELDS = %i[link title year country date genre length rating director actors].freeze
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
      check_field!(sort_field)
      @movies.sort_by(&sort_field)
    end

    def filter(filter_field)
      filter_field.reduce(@movies) do |res, (key, value)|
        res.select { |mov| mov.matches_filter?(key, value) }
      end
    end

    def stats(field)
      check_field!(field)
      all.flat_map(&field).sort
    end

    def stats_puts(field_array)
      field_array.each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }
                 .each do |k, v|
        puts "In #{k} include #{v} elements"
      end
    end

    def genre_exists?(genre)
      @genres ||= @movies.collect(&:genre)
      genres.include?(genre)
    end

    def each(&block)
      @movies.each(&block)
    end

    private

    def show_movie(movie)
      start_time = Time.now
      end_time = start_time + movie.length * 60
      print "Now showing: #{movie.title} #{start_time.strftime('%H:%M:%S')} - #{end_time.strftime('%H:%M:%S')}"
    end

    def parse_file(file_name)
      CSV.foreach(file_name, col_sep: '|', headers: FIELDS).map { |movie| Movie.build(movie, self) }
    end

    def check_field!(*fields)
      bad_fields = fields.reject { |field| FIELDS.include?(field) }
      raise("Params: #{bad_fields} not exist") unless bad_fields.empty?
    end

    def choice(movies)
      movies.sort_by { |movie| movie.rating * rand }.last
    end
  end
end
