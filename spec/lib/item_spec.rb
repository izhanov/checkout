# frozen_string_literal: true

RSpec.describe Item do
  context "when intializing without title & code" do
    it "raise errors ArgumentError" do
      expect{Item.new}.to raise_error(ArgumentError)
    end
  end

  context "when initializing with title & code" do
    it "returns Item instance" do
      expect(Item.new(title: "Green tea", code: "GR1", price: 3.11)).to be_a(Item)
    end
  end

  describe "#title" do
    it "returns item title" do
      item = Item.new(title: "Green tea", code: "GR1", price: 3.11)
      expect(item.title).to eq("Green tea")
    end
  end

  describe "#code" do
    it "returns item title" do
      item = Item.new(title: "Green tea", code: "GR1", price: 3.11)
      expect(item.code).to eq("GR1")
    end
  end

  describe "#price" do
    it "returns item price in BigDecimal" do
      item = Item.new(title: "Green tea", code: "GR1", price: 3.11)
      expect(item.price).to be_a(BigDecimal)
    end

    it "returns item price" do
      item = Item.new(title: "Green tea", code: "GR1", price: 99.78)
      expect(item.price).to eq(0.9978e2)
    end
  end
end
