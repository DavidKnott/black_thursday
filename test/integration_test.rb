require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test

  # attr_reader     :se

  # def setup
  #   @se = SalesEngine.from_csv({:items => "./data/items.csv", 
  #                               :merchants => "./data/merchants.csv"})
  # end

  def test_it_can_find_merchant_from_item
    se = SalesEngine.from_csv({:items => "./data/items.csv", 
                                :merchants => "./data/merchants.csv"})
    item = se.items.find_by_id("263405705")
    assert_equal '', item.merchant
    # assert_equal '', item.merchant.id
    # assert_equal '', item.merchant.name
  end



end