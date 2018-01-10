class Bundle
  attr_reader :item, :price_details

  def initialize(item, price_details)
    @item = item
    @price_details = price_details
  end

  def item_code
    item.code
  end
end