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

      rule = @promotion_rules.first
      total_price *= (1.0-rule.discount) if !rule.nil?  && total_price >= rule.value

      total_price.round(2)
    end
  end
end
