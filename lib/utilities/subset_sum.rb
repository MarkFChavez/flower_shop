module SubsetSum
  def self.compute(target, options)
    [].tap do |result|
      combination_sum(options.sort, 0, options.size - 1, target.to_i, [], result)
    end.last
  end

  private

  # https://github.com/bbp-labs/leetcode/blob/master/algorithms/combination_sum.rb
  def self.combination_sum(nums, lbound, ubound, target, tracing, result)
    sum = tracing.reduce(0, &:+)
    nums[lbound..ubound].each_with_index do |n, i|
      break if sum + n > target

      result << (tracing.dup << n) if sum + n == target
      combination_sum(nums, lbound + i, ubound, target, tracing.dup << n, result)
    end
  end
end