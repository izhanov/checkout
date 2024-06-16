# frozen_string_literal: true

module PricingRules
  class BuyOneGetOneFree < Default
    def total_price_of(items)
      items.each_with_index.reduce(0) do |total, (item, index)|
        total + apply_discount_to(item.price, even: (index + 1).even?)
      end
    end

    private

    def apply_discount_to(price, even:)
      if even
        0
      else
        price
      end
    end
  end
end
