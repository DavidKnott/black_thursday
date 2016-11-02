require 'pry'
require 'bigdecimal'

module Calculator

  def average(numbers_list)
    total = BigDecimal(0)
    numbers_list.each do |num|
      total += num
    end
    total / BigDecimal(numbers_list.count)
  end

  def standard_deviation(numbers_list, average)
    total = numbers_list.inject do |sum, number|
      sum + (number - average)**2
    end
    total = total/numbers_list.length - 1
    Math.sqrt(total)
  end

end