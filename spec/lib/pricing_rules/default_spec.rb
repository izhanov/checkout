# frozen_string_literal: true

RSpec.describe PricingRules::Default do
  describe ".new" do
    it "returns an instance of Default" do
      expect(PricingRules::Default.new).to be_a(PricingRules::Default)
    end
  end

  describe "#total_price_of" do
    it "returns the total price of items" do
      items = [
        Item.new(title: "Green tea", code: "GR1", price: 3.11),
        Item.new(title: "Green tea", code: "GR1", price: 3.11)
      ]

      expect(PricingRules::Default.new.total_price_of(items)).to eq(6.22)
    end
  end
end
