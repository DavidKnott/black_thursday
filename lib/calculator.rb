require 'pry'
require 'bigdecimal'

module Calculator

  def average(total, count)
    BigDecimal(BigDecimal(total) / BigDecimal(count))
  end

  def list_average(numbers_list)
    total = BigDecimal(0)
    numbers_list.each do |num|
      total += num
    end
    total / BigDecimal(numbers_list.count)
  end

  def standard_deviation(numbers_list)
    average = list_average(numbers_list)
    total = numbers_list.inject(0) do |sum, number|
      sum + (number - average)**2
    end
    total = total / (numbers_list.length - 1)
    Math.sqrt(total).round(2)
  end

end