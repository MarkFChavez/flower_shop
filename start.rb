require_relative './lib/shop'

shop = Shop.new

def print_result(how_many, code, result)
  puts "#{how_many} #{code} $#{result[:total_price].round(2)}"
  result[:items].each do |how_many, items|
    total = items.inject(0) do |total, hash|
      total + hash[:price]
    end

    puts "   #{items.size} x #{how_many} $#{items.first[:price]}"
  end
end

puts 'Welcome to Flower Shop v1.0!'
puts '============================'
puts ''

puts 'HERE ARE THE AVAILABLE BUNDLES:'
Shop::BUNDLES.each_with_index do |bundle, index|
  puts "#{index + 1}) [#{bundle.item_name}] Code: #{bundle.item_code}"
  puts '=============================='
  bundle.price_details.each do |how_many, price|
    puts "#{how_many} pcs. for $#{price}"
  end
  puts ''
end

puts 'Order a bundle by typing in the ff. formats'
puts 'e.g.'
puts '10 R12'
puts '15 L09'
puts '13 T58'

puts 'So, what\'s your order?'

begin
  how_many, code = gets.split(' ')
  result = shop.order(how_many, code)

  raise 'Unable to find the right bundles for this order. Bye!' unless result

  puts ''
  puts 'Order Details:'

  print_result(how_many, code, result)
rescue Exception => e
  puts e.message
end