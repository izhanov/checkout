# frozen_string_literal: true


RSpec.describe PricingRules::BuyOneGetOneFree do
  describe ".new" do
    it "returns an instance of BuyOneGetOneFree" do
      rule = PricingRules::BuyOneGetOneFree.new(item_code: "GR1")
      expect(rule).to be_a(PricingRules::BuyOneGetOneFree)
      expect(rule.class.superclass).to eq(PricingRules::Default)
    end
  end

  describe "#apply?" do
    it "returns true if item code matches" do
      rule = PricingRules::BuyOneGetOneFree.new(item_code: "GR1")
      expect(rule.apply?("GR1")).to be true
    end
  end

  describe "#total_price_of" do
    it "returns the total price of items" do
      items = [
        Item.new(title: "Green tea", code: "GR1", price: 3.11),
        Item.new(title: "Green tea", code: "GR1", price: 3.11),
        Item.new(title: "Green tea", code: "GR1", price: 3.11)
      ]

      rule = PricingRules::BuyOneGetOneFree.new(item_code: "GR1")
      expect(rule.total_price_of(items)).to eq(6.22)
    end
  end
end
