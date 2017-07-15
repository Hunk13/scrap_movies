class ClassicMovie < Movie
  def to_s
    "#{@title} — classical movie, director #{@director} (#{amount_director_movies} more of his films in the list)"
  end

  def movie_price
    Money.new(150)
  end

  private

  def amount_director_movies
    @movie_collection.filter(director: @director).size
  end
end
