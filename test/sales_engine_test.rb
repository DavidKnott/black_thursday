require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_initialize_sales_engine
    assert SalesEngine.new
  end

  def test_with_non_existing_csv
    se = SalesEngine.from_csv({:items => "./data/magic.csv"})
    assert_equal "Please Enter Valid File Names", se
  end

  def test_merchantrepository_exists
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    assert se.merchants    
  end

  def test_itemrepository_exists
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    assert se.items
  end

end