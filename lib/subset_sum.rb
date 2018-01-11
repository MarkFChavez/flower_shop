class SubsetSum
  def self.compute(target, options)
    new(target, options).compute
  end

  attr_reader :target, :options

  def initialize(target, options)
    @target = target
    @options = options
  end

  def compute
    [].tap do |result|
      combination_sum(options.sort, 0, options.size - 1, target, [], result)
    end.first
  end

  private

  # https://github.com/bbp-labs/leetcode/blob/master/algorithms/combination_sum.rb
  def combination_sum(nums, lbound, ubound, target, tracing, result)
    sum = tracing.reduce(0, &:+)
    nums[lbound..ubound].each_with_index do |n, i|
      break if sum + n > target

      result << (tracing.dup << n) if sum + n == target
      combination_sum(nums, lbound + i, ubound, target, tracing.dup << n, result)
    end
  end
end