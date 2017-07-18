# frozen_string_literal: true

module ScrapMovies
  class NewMovie < Movie
    def to_s
      "#{@title} — new movie. Release: #{now_year - @year} years ago."
    end

    def movie_price
      Money.new(500)
    end

    private

    def now_year
      Time.now.year
    end
  end
end
