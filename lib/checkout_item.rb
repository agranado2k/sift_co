module Syft
  class CheckoutItem
    attr_accessor :code, :price, :name, :quantity

    def initialize(item, quantity = 1)
      @code = item.code
      @name = item.name
      @price = item.price
      @quantity = quantity
    end
  end
end
