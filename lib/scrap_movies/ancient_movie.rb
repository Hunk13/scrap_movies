module ScrapMovies
  class AncientMovie < Movie
    def to_s
      "#{@title} — old movie (#{@year} year)"
    end

    def movie_price
      Money.new(100)
    end
  end
end
