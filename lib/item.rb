# frozen_string_literal: true

require "bigdecimal"
require "bigdecimal/util"

class Item
  attr_reader :title, :code, :price

  def initialize(title:, code:, price:)
    @title = title
    @code = code
    @price = BigDecimal(price.to_d).round(2)
  end
end
