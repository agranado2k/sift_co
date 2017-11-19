module Syft
  class Rule
    attr_reader :type, :code, :quantity, :value, :discount

    def initialize(args)
      @type = args[:type]
      @code = args[:code]
      @quantity = args[:quantity]
      @value = args[:value]
      @discount = args[:discount]
    end

    def apply(items=[], total=0)
      raise NotImplementedError
    end
  end
end

