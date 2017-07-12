class Netflix < MovieCollection
  include CashDesk
  attr_reader :money

  def initialize(file)
    super
    @money = 0
  end

  def show(params)
    mov = select_movie(params)
    raise("Not enough money. This movie cost #{mov.movie_price}. Your balance #{@money}") if @money < mov.movie_price
    show_movie(mov)
    @money -= mov.movie_price
  end

  def how_much?(input_movie_name)
    mov = filter(title: input_movie_name)[0]
    raise ArgumentError, "Movie '#{input_movie_name}' not found" if mov.nil?
    mov.movie_price
  end

  def pay(money)
    raise ArgumentError, "Value #{money} not correct" if money < 0
    pay_money(money)
  end

  private

  def select_movie(params)
    raise('Film Not Found') if filter(params).empty?
    filter(params).sort_by { |movie| movie.rating * rand }.last
  end
end
