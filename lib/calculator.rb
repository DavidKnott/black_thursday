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

end