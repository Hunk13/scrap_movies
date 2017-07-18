# frozen_string_literal: true

module ScrapMovies
  module CashDesk
    class Unauthorized < StandardError
      def initialize(msg = "The police'll be here soon!!!")
        super
      end
    end

    def cash
      (@money ||= Money.new(0)).format
    end

    def pay_money(amount)
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
