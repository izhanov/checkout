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
