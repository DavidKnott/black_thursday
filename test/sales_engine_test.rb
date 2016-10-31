require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_initialize_sales_engine
    assert SalesEngine.new
  end

  def test_it_can_take_in_a_hash_of_csv_file
    se = SalesEngine.from_csv({:items => "./data/items.csv"})
    assert_equal "./data/items.csv", se.items_file
  end

  def test_it_can_take_in_a_hash_of_multiple_csv_files
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    assert_equal "./data/items.csv", se.items_file
    assert_equal "./data/merchants.csv", se.merchants_file
  end

  def test_with_non_existing_csv
    se = SalesEngine.from_csv({:items => "./data/magic.csv"})
    assert_equal "Please Enter Valid File Names", se
  end

  def test_merchantrepository_exists
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    assert se.merchants    
  end

end