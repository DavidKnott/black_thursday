require 'pry'
require 'minitest/autorun'
require './lib/calculator'

class CalculatorTest < Minitest::Test
  include Calculator

  def test_average_for_two_numbers
    test_num1 = BigDecimal(10, 4)
    test_num2 = BigDecimal(20, 4)
    test_avg = average([test_num1, test_num2])
    test_expected_avg = BigDecimal(15, 4)

    assert_equal test_expected_avg, test_avg
    assert_equal BigDecimal, test_avg.class
  end

  def test_average_for_two_numbers
    test_nums = [BigDecimal(10, 4),
                BigDecimal(11.28, 4),
                BigDecimal(5.8, 4),
                BigDecimal(17.3, 4)]
    test_avg = average(test_nums)
    test_expected_avg = BigDecimal(11.095, 8)
    
    assert_equal test_expected_avg, test_avg
    assert_equal BigDecimal, test_avg.class
  end

end