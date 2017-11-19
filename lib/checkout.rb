module Syft
  class Checkout
    attr_reader :items, :promotion_rules

    def initialize(pr = [])
      @promotion_rules = pr;
      @items = {}
    end

    def scan(item)
      new_item = CheckoutItem.new(item)
      if @items[new_item.code].nil?
        @items[new_item.code] = new_item
      else
        @items[new_item.code].quantity += 1
      end
    end

    def total
      apply_promotion_rules_on_items

      total_price = calculate_total

      total_price = apply_promotion_rule_discount(total_price)

      total_price.round(2)
    end

    private
    def calculate_total
      items.reduce(0){|t, (code, item)| t += item.price * item.quantity}
    end

    def apply_promotion_rule_discount(total_price)
      promotion_rules.select{|r| r.type == "discount"}.each do |rule|
        total_price *= (1.0-rule.discount) if total_price >= rule.value
      end
      total_price
    end

    def apply_promotion_rules_on_items
      promotion_rules.select{|r| r.type == "item"}.each do |rule|
        item = @items[rule.code]
        item.price = rule.value if item && item.quantity >= rule.quantity
      end
    end
  end
end
