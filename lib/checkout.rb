# frozen_string_literal: true

class Checkout
  attr_reader :pricing_rules, :basket

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules.is_a?(Array) ? pricing_rules: [pricing_rules]
    @basket = {}
  end

  def scan(item)
    if basket[item.code]
      basket[item.code] += 1
    else
      basket[item.code] = 1
    end

    item.code
  end

  def total
  end
end
