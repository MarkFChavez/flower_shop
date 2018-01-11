require 'spec_helper'

RSpec.describe Shop do
  it 'uses the test bundle by default' do
    shop = Shop.new
    expect(shop.bundles.count).to eq 3
  end

  describe '#order!' do
    it 'raises error for invalid item code' do
      shop = Shop.new
      expect { shop.order!(10, 'invalid_code') }.to raise_error
    end

    it 'raises error for invalid size combinations' do
      shop = Shop.new
      invalid_size = 11
      expect { shop.order!(invalid_size, 'R12') }.to raise_error
    end

    it 'computes total' do
      shop = Shop.new
      order = shop.order!(10, 'R12')

      expect(order.total).to eq 12.99
    end

    it 'groups the items by combination' do
      shop = Shop.new
      order = shop.order!(10, 'R12')
      expected = {
        10 => [{ :number_of_pieces=>10, :price=>12.99 }]
      }

      expect(order.result).to eq expected
    end
  end
end