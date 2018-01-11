require_relative './subset_sum'

Item = Struct.new(:name, :code)
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

  # TODO: Handle invalid `how_many`
  def order(how_many, code)
    bundle_details = find_bundle_by_code(code).price_details
    bundle_size = SubsetSum.compute(how_many.to_i, bundle_details.keys)

    total = 0

    result = bundle_size.map do |size|
      return unless bundle_details.has_key?(size)
      total += bundle_details[size]

      { how_many: size, price: bundle_details[size] }
    end.compact.group_by { |item| item[:how_many] }

    { total_price: total, items: result }
  end

  private

  def find_bundle_by_code(code)
    BUNDLES.select { |bundle| bundle.item_code == code }.first
  end
end