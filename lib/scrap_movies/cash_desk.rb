module CashDesk
  class Unauthorized < StandardError
    def initialize(msg = "The police'll be here soon!!!")
      super
    end
  end

  def cash
    @money ||= 0
  end

  def pay_money(amount)
    @money ||= 0
    @money += amount
  end


  def take(who)
    if who == 'Bank'
      puts 'Collection is made'
      @money = 0
    else
      raise Unauthorized
    end
  end

  private

  def reset_cashbox(amount = 0)
    @money = amount
  end
end
