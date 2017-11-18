module Syft
  class Checkout
    attr_reader :items, :promotion_rules

    def initialize(pr = [])
      @promotion_rules = pr;
      @items = []
    end

    def scan(item)
      @items << item
    end

    def total
      total_price = items.reduce(0){|s,i| s += i.price; s}

      total_price *= 0.9 if !@promotion_rules.empty? && total_price >= 60

      total_price
    end
  end
end
