# frozen_string_literal: true
require "debug"
RSpec.describe PricingRules::Discount do
  describe ".new" do
    it "returns an instance of BuyOneGetOneFree" do
      rule = PricingRules::Discount.new(item_code: "GR1")
      expect(rule).to be_a(PricingRules::Discount)
      expect(rule.class.superclass).to eq(PricingRules::Default)
    end
  end

  describe "#apply?" do
    it "returns true if item code matches" do
      rule = PricingRules::Discount.new(item_code: "GR1")
      expect(rule.apply?("GR1")).to be true
    end
  end

  describe "#total_price_of" do
    it "returns the total price of items" do
      items = [
        Item.new(title: "Coffee", code: "CF1", price: 11.23),
        Item.new(title: "Coffee", code: "CF1", price: 11.23),
        Item.new(title: "Coffee", code: "CF1", price: 11.23)
      ]

      rule = PricingRules::Discount.new(item_code: "CF1", type: :propotional, value: "2/3", min_items: 3)
      expect(rule.total_price_of(items).round(2, half: :even)).to eq(22.46)
    end
  end
end
