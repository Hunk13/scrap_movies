# Class ModernMovie
class ModernMovie < Movie
  def to_s
    "#{@title} — modern movie. Actors: #{@actors.join(', ')}."
  end

  def movie_price
    3
  end
end
