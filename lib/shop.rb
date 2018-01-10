require_relative './bundle'
require_relative './item'
require_relative './subset_sum'

class Shop
  BUNDLES = [
    Bundle.new(Item.new('Roses', 'R12'), { 5 => 6.99, 10 => 12.99 }),
    Bundle.new(Item.new('Lilies', 'L09'), { 3 => 9.95, 6 => 16.95, 9 => 24.95 }),
    Bundle.new(Item.new('Tulips', 'T58'), { 3 => 5.95, 5 => 9.95, 9 => 16.99 })
  ]

  # TODO: Handle invalid `how_many`
  def order(how_many, code)
    bundle_details = get_bundle(code).price_details
    bundle_sizes = SubsetSum.compute(how_many, bundle_details.keys)

    total = 0

    result = bundle_sizes.map do |size|
      return unless bundle_details.has_key?(size)
      total += bundle_details[size]

      { how_many: size, price: bundle_details[size] }
    end.compact.group_by { |item| item[:how_many] }

    { total_price: total, items: result }
  end

  private

  def get_bundle(code)
    BUNDLES.select { |bundle| bundle.item_code == code }.first
  end
end