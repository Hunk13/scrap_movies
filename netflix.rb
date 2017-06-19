# class Netflix child from MovieCollection
class Netflix < MovieCollection
  attr_reader :money

  def initialize(file)
    super
    @money = 0
  end

  def show(params)
    movie = filter(params).sort_by { |mov| mov.rating * rand(10) }.last
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
