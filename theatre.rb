class Theatre < MovieCollection
  PERIOD = {
             'Morning' => { year: 1900...1945 },
             'Afternoon' => { genre: %w(Comedy Adventure) },
             'Evening' => { genre: %w(Drama Horror) }
           }

  def show(time)
    raise("Films not showing in #{time}") if PERIOD[time].nil?
    mov = filter(PERIOD[time]).select { |movie| movie.rating * rand }.last
    start_time = Time.now
    end_time = start_time + mov.length * 60
    puts "«Now showing: #{mov.title} #{start_time.strftime("%H:%M:%S")} - #{end_time.strftime("%H:%M:%S")}»"
  end

  def when?(movie_name)
    movie = filter(title: movie_name).first
    raise ArgumentError, "Movie '#{movie_name}' not found" if movie.nil?
    PERIOD.select { |_key, value| filter(value).include? movie }.map(&:first)
  end
end
