class Bundle
  attr_reader :item, :price_details

  def self.find_by_code!(bundles, code)
    bundle = Array(bundles).select { |bundle| bundle.code == code }.first

    unless bundle
      raise "[#{code}] - Cannot find bundle. Make sure you typed the right code."
    end

    bundle
  end

  def self.create(item, price_details)
    new(item, price_details)
  end

  def initialize(item, price_details)
    @item = item
    @price_details = price_details
  end

  def code; item.code; end
  def name; item.name; end
end