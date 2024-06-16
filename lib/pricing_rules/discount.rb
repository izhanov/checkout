# frozen_string_literal: true

module PricingRules
  class Discount < Default
    def total_price_of(items)
      if @options[:min_items] <= items.size
        items.reduce(0) do |total, item|
          total += apply_discount_to(item.price)
        end
      else
        default_total_price_of(items)
      end
    end

    private

    def apply_discount_to(price)
      case @options[:type]
      when :percentage
        (price * (@options[:value].to_d / 100.to_d)).round(3, half: :even)
      when :fixed
        @options[:value].to_d.round(3, half: :even)
      when :propotional
        (price * @options[:value].to_r).round(3, half: :even)
      else
        price.to_d.round(3, half: :even)
      end
    end
  end
end
