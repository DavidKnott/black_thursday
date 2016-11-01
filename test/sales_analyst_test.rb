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
  end

  def test_it_exists
    assert sales_analyst
  end

end
