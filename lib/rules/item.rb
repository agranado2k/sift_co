require_relative "../rule"

module Syft
  module Rules
    class Item < Rule
      def apply(items, total=0)
        item = items.select{|i| i.code == code}.first
        item.price = value if item && item.quantity >= quantity
        total
      end
    end
  end
end
