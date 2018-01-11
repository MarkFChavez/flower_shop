require_relative './subset_sum'

Item = Struct.new(:name, :code)
Order = Struct.new(:total, :result)
Bundle = Struct.new(:item, :price_details) do
  def self.for(item, details); new(item, details); end
  def item_code; item.code; end
  def item_name; item.name; end
end

class Shop
  BUNDLES = [
    Bundle.for(Item.new('Roses', 'R12'), { 5 => 6.99, 10 => 12.99 }),
    Bundle.for(Item.new('Lilies', 'L09'), { 3 => 9.95, 6 => 16.95, 9 => 24.95 }),
    Bundle.for(Item.new('Tulips', 'T58'), { 3 => 5.95, 5 => 9.95, 9 => 16.99 })
  ]

  def order!(how_many, code)
    bundle = find_bundle_by_code(code)
    raise 'Cannot find bundle. Make sure you typed the right code.' unless bundle

    price_details = bundle.price_details
    sizes = SubsetSum.compute(how_many.to_i, price_details.keys)
    raise 'Cannot find a proper bundle for this order.' unless sizes

    create_order(sizes, price_details)
  end

  private

  def find_bundle_by_code(code)
    BUNDLES.select { |bundle| bundle.item_code == code }.first
  end

  def create_order(sizes, details)
    total = 0
    valid_sizes = sizes.select { |s| details.has_key?(s) }

    result = valid_sizes.map do |size|
      total += details[size]
      { how_many: size, price: details[size] }
    end.compact.group_by { |item| item[:how_many] }

    Order.new(total.round(2), result)
  end
end