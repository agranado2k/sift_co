module Syft
  class Checkout
    attr_reader :items, :promotion_rules

    def initialize(pr = [])
      @promotion_rules = pr;
      @items = {}
    end

    def scan(item)
      @items[item.sku] = (@items.fetch(item.sku, []) << item)
    end

    def total
      total_price = 0
      items.each do |sku, item_list|
        total_price += item_list.reduce(0){|s,i| s += i.price; s}
      end

      item_rules = @promotion_rules.select{|r| r.type == :item}

      #item_rules.each do |rule|
        
      #end

      rule = @promotion_rules.first
      total_price *= (1.0-rule.discount) if !rule.nil?  && total_price >= rule.value

      total_price.round(2)
    end
  end
end
