require 'bigdecimal'

#Collection of generic methods used to perform
#various calculations to perform sales analysis
module Calculator

  WEEKDAYS = ["Sunday", "Monday", "Tuesday", "Wednesday",
              "Thursday", "Friday", "Saturday"]

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

  def bigdecimal_to_float(input)
    input.round(2).to_f
  end

  def bigdecimal_round(input)
    input.round(2)
  end

  def weekday(input)
    WEEKDAYS[input]
  end

  def percentage(fraction, total)
    result = BigDecimal(fraction) / BigDecimal(total) * 100
    bigdecimal_to_float(result)
  end

end