# frozen_string_literal: true

RSpec.describe Checkout do
  context "when initialize without pricing rules" do
    it "raise the ArgumentError" do
      expect { Checkout.new }.to raise_error(ArgumentError)
    end
  end

  context "when initialize with pricing rules object" do
    it "creates Checkout object instance with pricing rules" do
      pricing_rule = instance_double("PricingRules::Base")
      checkout = Checkout.new(pricing_rule)

      expect(checkout).to be_a(Checkout)
      expect(checkout.pricing_rules).to match_array([pricing_rule])
    end
  end

  describe "#scan" do
    context "when passing an Item object " do
      it "returns the item code" do
        pricing_rule = instance_double("PricingRules::Base")
        checkout = Checkout.new(pricing_rule)
        expect(checkout.scan(Item.new(title: "Green tea", code: "GR1"))).to eq("GR1")
      end
    end
  end

  describe "#pricing_rules" do
    it "returns array of pricing rules objects" do
      rule_1 = instance_double("PricingRules::Base")
      rule_2 = instance_double("PricingRules::BuyOneGetOne")

      checkout = Checkout.new([rule_1, rule_2])
      expect(checkout.pricing_rules).to match_array([rule_1, rule_2])
    end
  end
end
