require 'simplecov'
SimpleCov.start
require 'pry'
require 'minitest/autorun'
require './lib/calculator'

class CalculatorTest < Minitest::Test
  include Calculator

  def test_average_pair1
    test_total = 102
    test_count = 3
    test_avg = average(test_total, test_count)
    test_expected_avg = BigDecimal(34)

    assert_equal test_expected_avg, test_avg
    assert_equal BigDecimal, test_avg.class
  end

  def test_average_pair2
    test_total = 81
    test_count = 5
    test_avg = average(test_total, test_count)
    test_expected_avg = BigDecimal(81)/BigDecimal(5)

    assert_equal test_expected_avg, test_avg
    assert_equal BigDecimal, test_avg.class
  end

  def test_list_average_for_two_numbers
    test_num1 = BigDecimal(10)
    test_num2 = BigDecimal(20)
    test_avg = list_average([test_num1, test_num2])
    test_expected_avg = BigDecimal(15)

    assert_equal test_expected_avg, test_avg
    assert_equal BigDecimal, test_avg.class
  end

  def test_list_average_for_set_of_numbers
    test_nums = [BigDecimal(10, 4),
                BigDecimal(11.28, 4),
                BigDecimal(5.8, 4),
                BigDecimal(17.3, 4)]
    test_avg = list_average(test_nums)
    test_expected_avg = BigDecimal(11.095, 8)
    
    assert_equal test_expected_avg, test_avg
    assert_equal BigDecimal, test_avg.class
  end

  def test_standard_deviation_case1 
    test_nums = [3,4,5]
    test_std_dev = standard_deviation(test_nums)
    test_expected_std_dev = 1

    assert_equal test_expected_std_dev, test_std_dev
    assert_equal Float, test_std_dev.class
  end

  def test_standard_deviation_case2 
    test_nums = [5.7, 28.96, 15.99, 5.45]
    test_std_dev = standard_deviation(test_nums)
    test_expected_std_dev = 11.1 #11.10183

    assert_equal test_expected_std_dev, test_std_dev
    assert_equal Float, test_std_dev.class
  end

end