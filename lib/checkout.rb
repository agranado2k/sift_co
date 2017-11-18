module Syft
  class Checkout
    attr_reader :items

    def initialize
      @items = []
    end

    def scan(item)
      @items << item
    end

    def total
      items.reduce(0){|s,i| s += i.price; s}
    end
  end
end
