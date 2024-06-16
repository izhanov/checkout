# checkout
Simple cashier application

# Usage

1. After cloning repo go to this directory:

`cd ~/home/User/checkout`

2. Start the console:

`bin/console`

3. Run the code:

```ruby
pricing_rules = [
  PricingRules::BuyOneGetOneFree.new(item_code: "GR1"),
  PricingRules::Discount.new(item_code: "SR1", type: :fixed, value: 4.50, min_items: 3),
  PricingRules::Discount.new(item_code: "CF1", type: :propotional, value: "2/3", min_items: 3)
]

co = Checkout.new(pricing_rules)

item_0 = Item.new(code: "GR1", title: "Green tea", price: 3.11)
item_1 = Item.new(code: "SR1", title: "Strawberries", price: 5.00)
item_2 = Item.new(code: "GR1", title: "Green tea", price: 3.11)

co.scan(item_0)
co.scan(item_1)
co.scan(item_2)

price = co.total
# => £8.11
```

4. A few words about the pricing rules:

- `PricingRules::Default` - default pricing rule (no discount)
- `PricingRules::BuyOneGetOneFree` - buy one get one free
- `PricingRules::Discount` - discount rule
  - `type: :fixed` - fixed discount price for item (value: 4.50 => £4.50 of the price)
  - `type: :propotional` - propotional discount price for items (e.g. value: "2/3" (String) of the all price)
  - `type: :percentage` - 50% of the price (e.g 50% of £10.00 => £5.00)
  - `value: "£4.50"` - the value of discount type (e.g value: 4.5 => £4.50 of the price)


5. Run tests:

`bin/rspec`

