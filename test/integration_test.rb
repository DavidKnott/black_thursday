require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_engine'
require './lib/sales_analyst'
require 'pry'

class IntegrationTest < Minitest::Test

  #START of SalesEngine related tests

  def test_it_can_find_merchant_from_item
    se = SalesEngine.from_csv({:items => "./data/items.csv", 
                                :merchants => "./data/merchants.csv"})
    item = se.items.find_by_id(263405705)
    assert_equal 12334671, item.merchant.id
  end

  def test_it_can_find_items_from_merchant
      se = SalesEngine.from_csv({:items => "./data/items.csv", 
                                :merchants => "./data/merchants.csv"})
    merchant = se.merchants.find_by_id(12334671)
    assert_equal 263405705, merchant.items.first.id
  end

  #END of SalesEngine related tests

  #START of SalesAnalyst related tests

  def test_average_average_price_per_merchant
    se = SalesEngine.from_csv({:items => "./data/items.csv", 
                                :merchants => "./data/merchants.csv"})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 350.29, sales_analyst.average_average_price_per_merchant.round(2).to_f
  end
  
  #END of SalesAnalyst related tests


end