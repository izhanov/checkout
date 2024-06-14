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
  PricingRules::BuyOneGetOneFree.new("GR1")
]

co = Checkout.new(pricing_rules)

co.scan("GR1")
co.scan("SR1")
co.scan("GR1")
price = co.total
# => £22.45
```
