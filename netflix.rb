class Netflix < MovieCollection
  attr_reader :money

  def initialize(file)
    super
    @money = 0
  end

  def show(params)
    mov = filter(params).sort_by { |movie| movie.rating * rand }.last
    raise('Film Not Found') if filter(params).empty?
    raise("Not enough money. This movie cost #{mov.movie_price}. Your balance #{@money}") if @money < mov.movie_price
    start_time = Time.now
    end_time = start_time + mov.length * 60
    @money -= mov.movie_price
    puts "Now showing: #{mov.title} #{start_time.strftime('%H:%M:%S')} - #{end_time.strftime('%H:%M:%S')}"
  end

  def how_much?(input_movie_name)
    mov = filter(title: input_movie_name)[0]
    raise ArgumentError, "Movie '#{input_movie_name}' not found" if mov.nil?
    mov.movie_price
  end

  def pay(money)
    raise ArgumentError, "Value #{money} not correct" if money < 0
    @money =+ money
  end
end
