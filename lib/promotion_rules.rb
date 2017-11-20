module Syft
  class PromotionRules
    attr_reader :rules

    def initialize
      @rules = {}
    end

    def add_rule(rule)
      new_rule = Syft::Rule.create(rule)
      @rules[rule[:type]] = [] if @rules[rule[:type]].nil?
      @rules[rule[:type]] << new_rule
    end

    def apply_item_rules(items, total)
      rules.fetch("item", []).each do |rule|
        total = rule.apply(items, total)
      end
      total
    end

    def apply_discount_rules(items, total)
      rules.fetch("discount", []).each do |rule|
        total = rule.apply(items, total)
      end
      total
    end
  end
end
