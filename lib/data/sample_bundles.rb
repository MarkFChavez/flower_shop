require_relative '../bundle'
require_relative '../item'

module SampleBundles
  TEST = [
    Bundle.create(Item.new('Roses', 'R12'), { 5 => 6.99, 10 => 12.99 }),
    Bundle.create(Item.new('Lilies', 'L09'), { 3 => 9.95, 6 => 16.95, 9 => 24.95 }),
    Bundle.create(Item.new('Tulips', 'T58'), { 3 => 5.95, 5 => 9.95, 9 => 16.99 })
  ]

  CUSTOM = [
    Bundle.create(Item.new('Premium Ampersand Crewneck', 'T01'), { 3 => 6.99, 10 => 12.99 }),
    Bundle.create(Item.new('Premium Leather Mousepad', 'T02'), { 7 => 9.95, 2 => 16.95, 4 => 24.95 }),
    Bundle.create(Item.new('Slim Card Case', 'T03'), { 8 => 5.95, 3 => 9.95, 11 => 16.99 })
  ]
end