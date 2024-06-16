# frozen_string_literal: true

RSpec.describe Checkout do
  context "when initialize with pricing rules object" do
    it "creates Checkout object instance with pricing rules" do
      pricing_rule = instance_double("PricingRules::BuyOneGetOneFree")
      checkout = Checkout.new([pricing_rule])

      expect(checkout).to be_a(Checkout)
      expect(checkout.pricing_rules).to match_array([pricing_rule])
    end
  end

  describe "#scan" do
    context "when passing an Item object " do
      it "returns the item code" do
        pricing_rule = instance_double("PricingRules::BuyOneGetOneFree")
        checkout = Checkout.new([pricing_rule])
        expect(checkout.scan(Item.new(title: "Green tea", code: "GR1", price: 3.11))).to eq("GR1")
      end
    end
  end

  describe "#pricing_rules" do
    it "returns array of pricing rules objects" do
      rule_0 = double("PricingRules::BuyOneGetOneFree")

      checkout = Checkout.new([rule_0])
      expect(checkout.pricing_rules).to match_array([rule_0])
    end
  end

  describe "#total" do
    context "when basket is empty" do
      it "returns 0" do
        rule_0 = PricingRules::BuyOneGetOneFree.new(item_code: "GR1")
        checkout = Checkout.new(rule_0)
        expect(checkout.total).to eq(0)
      end
    end

    context "when basket has items" do
      context "when scan GR1, SR1, GR1, GR1, CF1" do
        it "returns 22.45" do
          rule_0 = PricingRules::BuyOneGetOneFree.new(item_code: "GR1")
          rule_1 = PricingRules::Discount.new(
            item_code: "SR1",
            type: :fixed,
            value: 4.50,
            min_items: 3
          )
          rule_2 = PricingRules::Discount.new(
            item_code: "CF1",
            type: :percentage,
            value: 33,
            min_items: 3
          )

          checkout = Checkout.new([rule_0, rule_1, rule_2])
          checkout.scan(Item.new(title: "Green tea", code: "GR1", price: 3.11))
          checkout.scan(Item.new(title: "Strawberries", code: "SR1", price: 5.00))
          checkout.scan(Item.new(title: "Green tea", code: "GR1", price: 3.11))
          checkout.scan(Item.new(title: "Green tea", code: "GR1", price: 3.11))
          checkout.scan(Item.new(title: "Coffee", code: "CF1", price: 11.23))
          expect(checkout.total).to eq(22.45)
        end
      end

      context "when scan GR1, GR1" do
        it "returns 3.11" do
          rule_0 = PricingRules::BuyOneGetOneFree.new(item_code: "GR1")

          checkout = Checkout.new(rule_0)
          checkout.scan(Item.new(title: "Green tea", code: "GR1", price: 3.11))
          checkout.scan(Item.new(title: "Green tea", code: "GR1", price: 3.11))
          expect(checkout.total).to eq(3.11)
        end
      end

      context "when scan SR1, SR1, GR1, SR1" do
        it "returns 16.61" do
          rule_0 = PricingRules::BuyOneGetOneFree.new(item_code: "GR1")
          rule_1 = PricingRules::Discount.new(
            item_code: "SR1",
            type: :fixed,
            value: 4.50,
            min_items: 3
          )

          checkout = Checkout.new([rule_0, rule_1])
          checkout.scan(Item.new(title: "Strawberries", code: "SR1", price: 5.00))
          checkout.scan(Item.new(title: "Strawberries", code: "SR1", price: 5.00))
          checkout.scan(Item.new(title: "Green tea", code: "GR1", price: 3.11))
          checkout.scan(Item.new(title: "Strawberries", code: "SR1", price: 5.00))
          expect(checkout.total).to eq(16.61)
        end
      end

      context "when scan GR1, CF1, SR1, CF1, CF1" do
        it "returns 30.57" do
          rule_0 = PricingRules::BuyOneGetOneFree.new(item_code: "GR1")
          rule_1 = PricingRules::Discount.new(
            item_code: "SR1",
            type: :fixed,
            value: 4.50,
            min_items: 3
          )
          rule_2 = PricingRules::Discount.new(
            item_code: "CF1",
            type: :propotional,
            value: "2/3",
            min_items: 3
          )

          checkout = Checkout.new([rule_0, rule_1, rule_2])
          checkout.scan(Item.new(title: "Green tea", code: "GR1", price: 3.11))
          checkout.scan(Item.new(title: "Coffee", code: "CF1", price: 11.23))
          checkout.scan(Item.new(title: "Strawberries", code: "SR1", price: 5.00))
          checkout.scan(Item.new(title: "Coffee", code: "CF1", price: 11.23))
          checkout.scan(Item.new(title: "Coffee", code: "CF1", price: 11.23))
          expect(checkout.total).to eq(30.57)
        end
      end
    end
  end
end
