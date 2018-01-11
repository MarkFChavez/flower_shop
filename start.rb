require_relative './lib/shop'

shop = Shop.new

def print_result(how_many, code, order)
  puts "#{how_many} #{code} $#{order.total}"
  order.result.each do |how_many, items|
    total = items.inject(0) do |total, hash|
      total + hash[:price]
    end

    puts "   #{items.size} x #{how_many} $#{items.first[:price]}"
  end
end

puts 'WELCOME TO FLOWER SHOP V1.0!'
puts '============================'
puts ''

puts 'Here are the available bundles:'
shop.bundles.each_with_index do |bundle, index|
  puts "#{index + 1}) [#{bundle.item_name}] Code: #{bundle.item_code}"
  puts '=============================='
  bundle.price_details.each do |how_many, price|
    puts "#{how_many} pcs. for $#{price}"
  end
  puts ''
end

try_again = true

while try_again do
  puts 'Order a bundle by typing in the ff. formats [number_of_pieces item_code] w/o the brackets:'

  begin

    how_many, code = gets.split(' ')
    order = shop.order!(how_many, code)

    puts ''
    puts 'Order Details:'

    print_result(how_many, code, order)

    puts ''
    puts 'Do you want to try again? (Y or N):'
    answer = gets
    try_again = answer.strip == 'Y' ? true : false

  rescue Exception => e
    try_again = true
    puts e.message
  end
end