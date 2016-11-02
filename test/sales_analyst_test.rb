require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'


class SalesAnalystTest < MiniTest::Test

  attr_reader     :sales_analyst

  def setup
    sales_engine = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    @sales_analyst = SalesAnalyst.new(sales_engine)

    sales_engine_small = SalesEngine.from_csv({:merchants => "./data/merchants_small.csv", :items => "./data/items.csv"})
    @sales_analyst_small = SalesAnalyst.new(sales_engine_small)    
  end

  def test_it_exists
    assert sales_analyst
  end


  def test_it_returns_merchants_list
    assert_equal 475, sales_analyst.merchants_list.length
  end


  def test_it_returns_items_list
    assert_equal 1367, sales_analyst.items_list.length
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 2.877894736842105, sales_analyst.average_items_per_merchant
  end

  def test_it_finds_how_man_items_one_merchant_has
    assert_equal 1, sales_analyst.items_per_merchant(12334174)
  end

  def test_it_makes_array_for_how_many_items_each_merchant_has
    assert_equal 475, sales_analyst.items_per_merchant_list.count
  end

  def test_it_finds_average_items_per_merchant_standard_deviation
    skip
    assert_equal 3.099372766779748, sales_analyst.average_items_per_merchant_standard_deviation
  end


  def test_it_lists_merchants_with_item_count_over_one_standard_devation
    skip
    assert_equal 65, sales_analyst.merchants_with_high_item_count.count
  end


  def test_average_item_price_for_merchant
    #Unit prices for this merchant as from CSV file: 2390, 2390, 2390, 2390, 1890.
    test_average = sales_analyst.average_item_price_for_merchant(12334315)
    assert_equal 22.9, test_average.to_f 
  end

  def test_average_average_price_per_merchant
    test_average = sales_analyst.average_average_price_per_merchant
    assert_equal 22.9, test_average.to_f 
  end

end
