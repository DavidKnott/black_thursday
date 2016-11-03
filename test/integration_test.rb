require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require './lib/sales_engine'
require './lib/sales_analyst'
require 'pry'

class IntegrationTest < Minitest::Test
  attr_reader :se,
              :test_merchant,
              :test_customer

  def setup
    @se = SalesEngine.from_csv({:items => "./data/items.csv", 
                                :merchants => "./data/merchants.csv",
                                :invoices => "./data/invoices.csv",
                                :customers => "./data/customers.csv"})
    @test_merchant = se.merchants.find_by_id(12334671)
    @test_customer = se.customers.find_by_id(40)
  end

  #START of SalesEngine related tests

  def test_it_can_find_merchant_from_item
    item = se.items.find_by_id(263405705)
    assert_equal 12334671, item.merchant.id
  end

  def test_it_can_find_items_from_merchant
    test_result = test_merchant.items
    assert_equal Array, test_result.class
    assert_equal Item, test_result.first.class
    assert_equal 263405705, test_result.first.id
  end

  def test_it_can_find_invoices_for_merchant
    test_result = test_merchant.invoices
    assert_equal Array, test_result.class
    assert_equal Invoice, test_result.first.class
    assert_equal 207, test_result.first.id
  end

  def test_find_customer_for_merchant
    test_result = test_merchant.customers
    assert_equal Array, test_result.class
    assert_equal Customer, test_result.first.class
    assert_equal 14, test_result.count
  end

  def test_find_customer_for_merchant
    test_result = test_customer.merchants
    assert_equal Array, test_result.class
    assert_equal Merchant, test_result.first.class
    assert_equal 1000, test_result.count
  end

  #END of SalesEngine related tests

  #START of SalesAnalyst related tests

  def test_average_average_price_per_merchant
    # se = SalesEngine.from_csv({:items => "./data/items.csv", 
    #                             :merchants => "./data/merchants.csv"})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 350.29, sales_analyst.average_average_price_per_merchant.round(2).to_f
  end
  
  #END of SalesAnalyst related tests


end