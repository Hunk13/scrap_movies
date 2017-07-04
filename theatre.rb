class Theatre < MovieCollection
  PERIOD = {
             'Morning' => { year: 1900...1945 },
             'Afternoon' => { genre: %w(Comedy Adventure) },
             'Evening' => { genre: %w(Drama Horror) }
           }

  def show(time)
    raise("Films not showing in #{time}") if PERIOD[time].nil?
    mov = select_movie(time)
    start_time = Time.now
    end_time = start_time + mov.length * 60
    print "Now showing: #{mov.title} #{start_time.strftime("%H:%M:%S")} - #{end_time.strftime("%H:%M:%S")}"
  end

  def when?(movie_name)
    movie = filter(title: movie_name)[0]
    raise ArgumentError, "Movie '#{movie_name}' not found" if movie.nil?
    PERIOD.select { |_key, value| filter(value).include? movie }.map(&:first)
  end

  def select_movie(time)
    filter(PERIOD[time]).sort_by { |movie| movie.rating * rand }.last
  end
end
