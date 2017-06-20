# class Netflix child from MovieCollection
class Netflix < MovieCollection
  attr_reader :money

  def initialize(file)
    super
    @money = 0
  end

  def show(params)
    movie = filter(params).sort_by { |movie| movie.rating * rand }.last
    raise("Film Not Found") if filter(params).empty?
    raise("Not enough money. This movie cost #{movie.movie_price}. Your balance #{@money}") if @money < movie.movie_price
    start_time = Time.now
    end_time = start_time + movie.length * 60
    @money -= movie.movie_price
    puts "Now showing: #{movie.title} #{start_time.strftime('%H:%M:%S')} - #{end_time.strftime('%H:%M:%S')}"
  end

  def how_much?(input_movie_name)
    filter(title: input_movie_name).select { |movie| movie.rating * rand }.last.movie_price
  end

  def pay(money)
    @money =+ money
  end
end
