class AncientMovie < Movie
  def to_s
    "#{@title} — old movie (#{@year} year)"
  end

  def movie_price
    1
  end
end
