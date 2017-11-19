require_relative "../rule"

module Syft
  module Rules
    class Discount < Rule
      def apply(items=[], total=0)
        total *= (1.0 - discount) if total >= value
        total
      end
    end
  end
end
