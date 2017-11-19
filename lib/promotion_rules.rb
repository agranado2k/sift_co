module Syft
  class PromotionRules
    attr_reader :rules

    def initialize(rules=[])
      @rules = rules
    end

    def apply_rules(total=0)
      raise MethodNotImplemented
    end
  end
end
