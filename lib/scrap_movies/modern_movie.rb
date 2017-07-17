module ScrapMovies
  class ModernMovie < Movie
    def to_s
      "#{@title} — modern movie. Actors: #{@actors.join(', ')}."
    end

    def movie_price
      Money.new(300)
    end
  end
end
