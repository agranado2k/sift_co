module Syft
  module Rules
    class Discount < Syft::Rule
      def apply(items=[], total=0)
        total = total * (1.0 - discount) if total >= value
        total
      end
    end
  end
end
