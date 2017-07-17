module ScrapMovies
  class Theatre < MovieCollection
    include CashDesk

    def initialize(file)
      super
    end

    PERIOD = {
      'Morning' => { year: 1900...1945 },
      'Afternoon' => { genre: %w(Comedy Adventure) },
      'Evening' => { genre: %w(Drama Horror) }
    }.freeze

    TIME_PERIODS = {
      'Morning' => Time.parse('05:00')..Time.parse('10:59'),
      'Afternoon' => Time.parse('11:00')..Time.parse('16:59'),
      'Evening' => Time.parse('17:00')..Time.parse('23:59')
    }.freeze

    PRICES = {
      'Morning' => Money.new(300),
      'Afternoon' => Money.new(500),
      'Evening' => Money.new(1000)
    }.freeze

    def show(time)
      mov = select_movie(time)
      show_movie(mov)
    end

    def when?(movie_name)
      movie = filter(title: movie_name)[0]
      raise ArgumentError, "Movie '#{movie_name}' not found" if movie.nil?
      PERIOD.select { |_key, value| filter(value).include? movie }.map(&:first)
    end

    def buy_ticket(time)
      period = find_period(time)
      raise ArgumentError, 'The Cinema is closed' if period.nil?

      movie = choice(filter(PERIOD[period]))
      pay_money(PRICES[period])
      "You have paid ticket on movie #{movie.title}"
    end

    private

    def select_movie(time)
      raise("Films not showing in #{time}") if PERIOD[time].nil?
      filter(PERIOD[time]).sort_by { |movie| movie.rating * rand }.last
    end

    def find_period(time)
      TIME_PERIODS.select { |_key, value| value === Time.parse(time)  }.keys.first
    end
  end
end
