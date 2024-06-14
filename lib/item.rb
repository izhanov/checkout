# frozen_string_literal: true

class Item
  attr_reader :title, :code

  def initialize(title:, code:)
    @title = title
    @code = code
  end
end
