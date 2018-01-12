require_relative './data/sample_bundles'
require_relative './utilities/subset_sum'
require_relative './bundle'
require_relative './item'
require_relative './order'

class Shop
  attr_reader :bundles

  def initialize(bundles = SampleBundles::TEST)
    @bundles = bundles
  end

  def order!(number_of_pieces, code)
    bundle = Bundle.find_by_code!(bundles, code)
    price_details = bundle.price_details
    available_bundles = price_details.keys

    best_subset = SubsetSum.compute(number_of_pieces, price_details.keys)
    raise "[#{number_of_pieces} #{code}] - Cannot find a proper bundle for this order." unless best_subset

    build_order(best_subset, price_details)
  end

  private

    def build_order(sizes, details)
      total = 0
      valid_sizes = sizes.select { |s| details.has_key?(s) }

      result = valid_sizes.map do |size|
        total += details[size]
        { number_of_pieces: size, price: details[size] }
      end.compact.group_by { |item| item[:number_of_pieces] }

      Order.new(total.round(2), result)
    end
end