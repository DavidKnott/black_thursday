require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

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


end