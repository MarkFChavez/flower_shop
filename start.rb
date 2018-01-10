require_relative './lib/shop'

shop = Shop.new

def print_result(result)
  puts "25 R12 $#{result[:total_price]}"
  result[:items].each do |how_many, items|
    total = items.inject(0) do |total, hash|
      total + hash[:price]
    end

    puts "   #{items.size} x #{how_many} $#{items.first[:price]}"
  end
end

puts "SHOP"
puts "####"

puts ''

Shop::BUNDLES.each do |bundle|
  puts bundle.item_name
  bundle.price_details.each do |how_many, price|
    puts "#{how_many} for $#{price}"
  end
  puts ''
end

puts ''

puts "Order 25 Roses"
result = shop.order(25, 'R12')
print_result(result)

puts ''

puts "Order 18 Lilies"
result = shop.order(18, 'L09')
print_result(result)