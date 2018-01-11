require_relative './lib/shop'

shop = Shop.new # uses default bundle

def print_result(number_of_pieces, code, order)
  puts "#{number_of_pieces} #{code} $#{order.total}"
  order.result.each do |number_of_pieces, items|
    total = items.inject(0) do |total, hash|
      total + hash[:price]
    end

    puts "   #{items.size} x #{number_of_pieces} $#{items.first[:price]}"
  end
end

puts 'WELCOME TO FLOWER SHOP V1.0!'
puts '============================'
puts ''

puts 'Here are the available bundles:'
shop.bundles.each_with_index do |bundle, index|
  puts "#{index + 1}) [#{bundle.item_name}] Code: #{bundle.item_code}"
  puts '=============================='
  bundle.price_details.each do |number_of_pieces, price|
    puts "#{number_of_pieces} pcs. for $#{price}"
  end
  puts ''
end

try_again = true

while try_again do
  puts 'Order a bundle by typing in the ff. formats [number_of_pieces item_code] w/o the brackets:'

  begin

    number_of_pieces, code = gets.split(' ')
    order = shop.order!(number_of_pieces, code)

    puts ''
    puts 'Order Details:'

    print_result(number_of_pieces, code, order)

    puts ''
    puts 'Do you want to try again? (Y or N):'
    try_again = gets.strip == 'Y' ? true : false

  rescue Exception => e
    try_again = true
    puts e.message
  end
end