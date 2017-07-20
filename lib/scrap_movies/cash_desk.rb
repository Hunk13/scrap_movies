# frozen_string_literal: true

module ScrapMovies
  module CashDesk
    class Unauthorized < StandardError; end

    class NegativeAmount < StandardError; end

    def cash
      (@money ||= Money.new(0)).format
    end

    def pay_money(amount)
      raise NegativeAmount, 'Amount should be positive' if amount.negative?
      cash
      @money += Money.new(amount * 100)
    end

    def take(who)
      raise Unauthorized, "The police'll be here soon!!!" unless who == 'Bank'
      @money = Money.new(0)
      puts 'Collection is made'
    end
  end
end
