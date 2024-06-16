# frozen_string_literal: true

module PricingRules
  class Default
    def initialize(options = {})
      @options = options
    end

    def apply?(item_code)
      @options[:item_code] == item_code
    end

    def total_price_of(items)
      default_total_price_of(items)
    end

    private

    def default_total_price_of(items)
      items.reduce(0) do |total, item|
        total + item.price
      end
    end
  end
end
