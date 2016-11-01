require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

  attr_reader   :test_config

  def setup
    # @test_config = {:items => "./data/items.csv", :merchants => "./data/merchants.csv"}
    @test_config = {:merchants => "./data/merchants.csv", :items => "./data/items.csv"}
  end

  # def test_initialize_sales_engine
  #   assert SalesEngine.new
  # end

  # def test_with_non_existing_csv
  #   se = SalesEngine.from_csv({:items => "./data/magic.csv"})
  #   assert_equal "Please Enter Valid File Names", se
  # end

  def test_merchantrepository_exists
    se = SalesEngine.from_csv(test_config)
    assert se.merchants    
  end

  def test_itemrepository_exists
    se = SalesEngine.from_csv(test_config)
    assert se.items
  end

  def test_it_calls_merchant_repo_and_finds_merchants_by_merchant_id
    se = SalesEngine.from_csv(test_config)
    assert_equal 12334159, se.find_merchant_by_merchant_id(12334159).id
  end

   def test_it_calls_merchant_repo_and_finds_items_by_merchant_id
    se = SalesEngine.from_csv(test_config)
    refute_empty se.find_items_by_merchant_id(12334159)
  end

end