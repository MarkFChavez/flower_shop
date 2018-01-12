class Bundle
  attr_reader :item, :price_details

  def self.create(item, price_details)
    new(item, price_details)
  end

  def self.find_by_code(bundles, code)
    bundles.select { |bundle| bundle.item_code == code }.first
  end

  def initialize(item, price_details)
    @item = item
    @price_details = price_details
  end

  def item_code; item.code; end
  def item_name; item.name; end
end