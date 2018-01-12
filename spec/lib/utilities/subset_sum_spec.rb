require 'spec_helper'

RSpec.describe SubsetSum do
  context 'Given a target of `10`' do
    before(:all) do
      @target = 10
    end

    context 'with [5, 10]' do
      it 'returns one item' do
        possible_values = [5, 10]

        count = SubsetSum.compute(@target, possible_values).count

        expect(count).to eq 1
      end
    end

    context 'with [3, 7, 5]' do
      it 'returns two items' do
        count = SubsetSum.compute(@target, [3, 7, 5]).count
        expect(count).to eq 2
      end
    end
  end
end