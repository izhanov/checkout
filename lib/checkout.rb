# frozen_string_literal: true
require "debug"

class Checkout
  attr_reader :pricing_rules, :basket

  def initialize(pricing_rules = [])
    @pricing_rules = pricing_rules.is_a?(Array) ? pricing_rules: [pricing_rules]
    @default_pricing_rule = PricingRules::Default.new
    @basket = {}
  end

  def scan(item)
    if basket[item.code]
      basket[item.code] << item
    else
      basket[item.code] = [item]
    end

    item.code
  end

  def total
    basket.reduce(0) do |total, (item_code, items)|
      total + pricing_rule_of(item_code).total_price_of(items)
    end.round(2, half: :even)
  end

  private

  def pricing_rule_of(item_code)
    find_rule(item_code) || @default_pricing_rule
  end

  def find_rule(item_code)
    pricing_rules.detect { |pricing_rule| pricing_rule.apply?(item_code) }
  end
end
