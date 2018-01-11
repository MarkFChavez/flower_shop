require_relative './subset_sum'

Item = Struct.new(:name, :code)
Order = Struct.new(:total, :result)
Bundle = Struct.new(:item, :price_details) do
  def self.for(item, details); new(item, details); end
  def item_code; item.code; end
  def item_name; item.name; end
end

TEST_BUNDLES = [
  Bundle.for(Item.new('Roses', 'R12'), { 5 => 6.99, 10 => 12.99 }),
  Bundle.for(Item.new('Lilies', 'L09'), { 3 => 9.95, 6 => 16.95, 9 => 24.95 }),
  Bundle.for(Item.new('Tulips', 'T58'), { 3 => 5.95, 5 => 9.95, 9 => 16.99 })
]

CUSTOM_BUNDLES = [
  Bundle.for(Item.new('Premium Ampersand Crewneck', 'T01'), { 3 => 6.99, 10 => 12.99 }),
  Bundle.for(Item.new('Premium Leather Mousepad', 'T02'), { 7 => 9.95, 2 => 16.95, 4 => 24.95 }),
  Bundle.for(Item.new('Slim Card Case', 'T03'), { 8 => 5.95, 3 => 9.95, 11 => 16.99 })
]

class Shop
  attr_reader :bundles

  def initialize(bundles = TEST_BUNDLES)
    @bundles = bundles
  end

  def order!(number_of_pieces, code)
    bundle = find_bundle_by_code(code)
    raise 'Cannot find bundle. Make sure you typed the right code.' unless bundle

    price_details = bundle.price_details
    sizes_combination = find_right_sizes_combination(price_details, number_of_pieces)
    raise 'Cannot find a proper bundle for this order.' unless sizes_combination

    create_order(sizes_combination, price_details)
  end

  private

    def find_bundle_by_code(code)
      bundles.select { |bundle| bundle.item_code == code }.first
    end

    def find_right_sizes_combination(price_details, number_of_pieces)
      available_bundles = price_details.keys
      SubsetSum.compute(number_of_pieces, available_bundles)
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