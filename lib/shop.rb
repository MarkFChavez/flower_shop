require_relative './bundle'
require_relative './item'
require_relative './subset_sum'

class Shop
  BUNDLES = [
    ROSES_BUNDLE = Bundle.new(Item.new('Roses', 'R12'), { 5 => 6.99, 10 => 12.99 }),
    LILIES_BUNDLE = Bundle.new(Item.new('Lilies', 'L09'), { 3 => 9.95, 6 => 16.95, 9 => 24.95 }),
    TULIPS_BUNDLE = Bundle.new(Item.new('Tulips', 'T58'), { 3 => 5.95, 5 => 9.95, 9 => 16.99 })
  ]

  def self.order(name, how_many)
    bundle_details = get_bundle(name).price_details
    bundle_sizes = SubsetSum.compute(how_many, bundle_details.keys)

    bundle_sizes.map do |size|
      if bundle_details.has_key?(size)
        { how_many: size, price: bundle_details[size] }
      end
    end.compact
  end

  private

  def self.get_bundle(name)
    BUNDLES.select { |bundle| bundle.item_name == name }.first
  end
end