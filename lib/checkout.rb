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
      total_price = 0
      apply_promotion_rules_on_items(total_price)

      total_price = calculate_total

      total_price = apply_promotion_rule_discount(total_price)

      total_price.round(2)
    end

    private
    def calculate_total
      items.reduce(0){|t, (code, item)| t += item.price * item.quantity}
    end

    def apply_promotion_rule_discount(total_price)
      promotion_rules.apply_discount_rules(@items.values, total_price)
    end

    def apply_promotion_rules_on_items(total_price)
      promotion_rules.apply_item_rules(@items.values, total_price)
    end
  end
end
