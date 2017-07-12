class Theatre < MovieCollection
  include CashDesk

  PERIOD = {
             'Morning' => { year: 1900...1945 },
             'Afternoon' => { genre: %w(Comedy Adventure) },
             'Evening' => { genre: %w(Drama Horror) }
           }

  def show(time)
    mov = select_movie(time)
    show_movie(mov)
  end

  def when?(movie_name)
    movie = filter(title: movie_name)[0]
    raise ArgumentError, "Movie '#{movie_name}' not found" if movie.nil?
    PERIOD.select { |_key, value| filter(value).include? movie }.map(&:first)
  end

  def buy_ticket(day_period)
    fill(PERIODS[day_period][:price])
    movie = choose_movie(PERIODS[day_period])
    if movie.nil?
      'No movie selected'
    else
      "You bought a ticket for #{movie.title}"
    end
  end

  private

  def select_movie(time)
    raise("Films not showing in #{time}") if PERIOD[time].nil?
    filter(PERIOD[time]).sort_by { |movie| movie.rating * rand }.last
  end
end
