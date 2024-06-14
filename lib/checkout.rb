# frozen_string_literal: true

class Checkout
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @basket = []
  end

  def scan(item)
  end

  def total
  end
end
