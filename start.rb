require_relative './lib/shop'

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

shop = Shop.new

puts 'Here are the available bundles:'
shop.bundles.each_with_index do |bundle, index|
  puts "#{index + 1}) [#{bundle.name}] Code: #{bundle.code}"
  puts '=============================='
  bundle.price_details.each do |number_of_pieces, price|
    puts "#{number_of_pieces} pcs. for $#{price}"
  end
  puts ''
end

STOP_ACTION = 'stop'

puts "Place your order(s). Type `#{STOP_ACTION}` to submit"

result = []

while input = gets do
  break if input.strip == STOP_ACTION
  result << input
end

puts ''
puts 'Order Summary'
puts '-------------'

result.each do |order|
  begin
    number_of_pieces, code = order.split(' ')
    order_summary = shop.order!(number_of_pieces, code)
    print_result(number_of_pieces, code, order_summary)
  rescue => e
    puts e.message
  end
end