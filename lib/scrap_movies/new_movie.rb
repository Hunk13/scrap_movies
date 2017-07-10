class NewMovie < Movie
  def to_s
    "#{@title} — new movie. Release: #{now_year - @year} years ago."
  end

  def movie_price
    5
  end

  private

  def now_year
    Time.now.year
  end
end
