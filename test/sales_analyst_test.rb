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
